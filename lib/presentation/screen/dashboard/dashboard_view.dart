import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_project/data/model/todo_info.dart';
import 'package:todo_list_project/data/provider/todo_local_data_provider.dart';
import 'package:todo_list_project/domain/business/tab_bar_bloc.dart';
import 'package:todo_list_project/domain/repository/todo_repository.dart';
import 'package:todo_list_project/presentation/resources/values_manager.dart';
import 'package:todo_list_project/presentation/widgets/item_todos.dart';

import '../../../db/todo/todo_db.dart';
import '../../../domain/business/todo_list_bloc.dart';
import '../../resources/string_manager.dart';
import '../../widgets/dialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TodoRepository>(
        create: (BuildContext repositoryContext) => TodoRepository(
            todoLocalDataProvider:
                TodoLocalDataProvider(todoDBContext: TodoObDB())),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TabBarCubit>(
              create: (BuildContext blocContext) => TabBarCubit(),
            ),
            BlocProvider<TodoListBloc>(
              create: (BuildContext blocContext) => TodoListBloc(
                  todoRepository:
                      RepositoryProvider.of<TodoRepository>(blocContext),
                  tabBarCubit: BlocProvider.of<TabBarCubit>(blocContext)),
            ),
          ],
          child: const _DashboardScreen(),
        ));
  }
}

class _DashboardScreen extends StatefulWidget {
  const _DashboardScreen({Key? key}) : super(key: key);

  @override
  State<_DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<_DashboardScreen> {
  var titleAppBars = [
    AppStrings.all,
    AppStrings.complete,
    AppStrings.incomplete
  ];

  late String valueText;
  bool isShowDialogError = false;
  final TextEditingController _textFieldController = TextEditingController();
  StreamSubscription? tabBarEvent;
  StreamSubscription? errorEvent;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    BlocProvider.of<TabBarCubit>(context).switchTab(index);
  }

  @override
  void initState() {
    context.read<TodoListBloc>().add(TodoListLoading()); //.loadTodos();
    listenTabChange();
    super.initState();
  }

  void listenTabChange() {
    tabBarEvent = BlocProvider.of<TabBarCubit>(context).stream.listen((event) {
      if (event is SwitchTabEvent) {
        setState(() {
          _selectedIndex = event.tabOption.index;
        });
      }
    });
    errorEvent = BlocProvider.of<TodoListBloc>(context).stream.listen((event) {
      if (event.isError && !isShowDialogError) {
        displayDialogOneAction(context,
            title: AppStrings.alert,
            message: AppStrings.someThingWasWrong,
            titleAction: AppStrings.agree,
            actionCallback: _onErrorConfirm);
        isShowDialogError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBars[_selectedIndex]),
      ),
      body: _buildListTodos,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house_outlined),
            label: AppStrings.all,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline_rounded),
            label: AppStrings.complete,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle_rounded),
            label: AppStrings.incomplete,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onCreateTodo,
        child: const Icon(
          Icons.add,
          size: AppSize.s28,
        ),
      ),
    );
  }

  void _onCreateTodo() {
    displayTextInputDialog(context,
        title: AppStrings.createNewTodo,
        titleActionLeft: AppStrings.cancel,
        titleActionRight: AppStrings.ok,
        actionDegree: _onCancel,
        actionAgree: _onAgree,
        hintText: AppStrings.pleaseInputYourTodo,
        onChange: _onContentChange,
        textFieldController: _textFieldController);
  }

  Widget get _buildListTodos {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (BuildContext builderContext, TodoListState state) {
        if (state.isLoading || state.todos.isEmpty) {
          return _buildEmptyTodoBackground();
        }
        return ListView.builder(
          itemBuilder: _buildTodoItem,
          itemCount: state.todos.length,
        );
      },
    );
  }

  Widget _buildEmptyTodoBackground() {
    return AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/img_empty_todo_list.jpg'));
  }

  Widget _buildTodoItem(BuildContext context, int index) {
    return ItemTodo(
      data: BlocProvider.of<TodoListBloc>(context).state.todos[index],
    );
  }

  void _onContentChange(String value) {
    valueText = value;
  }

  void _onErrorConfirm() {
    context.read<TodoListBloc>().add(TodoListErrorConfirmed());
    isShowDialogError = false;
    Navigator.pop(context);
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _onAgree() {
    context
        .read<TodoListBloc>()
        .add(TodoListInserted(todoInfo: TodoInfo(valueText, false)));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    tabBarEvent?.cancel();
    errorEvent?.cancel();
    context.read<TodoListBloc>().dispose();
    super.dispose();
  }
}
