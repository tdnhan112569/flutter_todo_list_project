import 'package:test/test.dart';
import 'package:todo_list_project/data/provider/todo_local_data_provider.dart';
import 'package:todo_list_project/db/todo/todo_db.dart';
import 'package:todo_list_project/domain/business/tab_bar_bloc.dart';
import 'package:todo_list_project/domain/business/todo_list_bloc.dart';
import 'package:todo_list_project/domain/repository/todo_repository.dart';

void main() {
  group('Todo Bloc Testing', () {
    late TabBarCubit tabBarCubit;
    late TodoListBloc todoListBloc;
    late TodoLocalDataProvider todoLocalDataProvider;
    late TodoRepository todoRepository;
    late TodoObDB todoDB;

    setUp(() {
      tabBarCubit = TabBarCubit();
      todoDB = TodoObDB();
      todoLocalDataProvider = TodoLocalDataProvider(todoDBContext: todoDB);
      todoRepository =
          TodoRepository(todoLocalDataProvider: todoLocalDataProvider);
    });

    test('testing error event the field isError must be true', () async {
      todoListBloc = TodoListBloc(
          tabBarCubit: tabBarCubit, todoRepository: todoRepository);
      // event of BLOC is async, we must delay to get the expected result after sending event
      // delay 2 second for the loading event and init state event are complete in the first time
      await Future.delayed(const Duration(seconds: 2));
      todoListBloc.add(TodoListNotifyError());
      await Future.delayed(const Duration(seconds: 2));
      expect(todoListBloc.state.isError, true);
    });

    test('testing error confirmed event the field isError must be false',
        () async {
      todoListBloc = TodoListBloc(
          tabBarCubit: tabBarCubit, todoRepository: todoRepository);
      // event of BLOC is async, we must delay to get the expected result after sending event
      // delay 2 second for the loading event and init state event are complete in the first time
      await Future.delayed(const Duration(seconds: 2));
      todoListBloc.add(TodoListNotifyError());
      await Future.delayed(const Duration(seconds: 2));
      todoListBloc.add(TodoListErrorConfirmed());
      await Future.delayed(const Duration(seconds: 2));
      expect(todoListBloc.state.isError, false);
    });

    test('testing error event the field isError must be true', () {
      todoListBloc = TodoListBloc(
          tabBarCubit: tabBarCubit, todoRepository: todoRepository);
      expect(todoListBloc.state.isError, false);
    });

    // INSERT, DELETE, READ, UPDATE can't testable because ObjectBox Database init is failed
  });
}
