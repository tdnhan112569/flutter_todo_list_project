import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_project/data/model/todo_info.dart';
import 'package:todo_list_project/presentation/resources/string_manager.dart';
import 'package:todo_list_project/presentation/resources/style_manager.dart';
import 'package:todo_list_project/presentation/resources/values_manager.dart';

import '../../domain/business/todo_list_bloc.dart';
import 'dialog.dart';

enum TodoAction { edit, delete }

class ItemTodo extends StatelessWidget {
  final TodoInfo data;

  const ItemTodo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          vertical: AppSize.s8, horizontal: AppSize.s16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSize.s8)
            .copyWith(right: AppSize.s8),
        constraints: BoxConstraints(
          minHeight: AppSize.s28,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: data.isChecked,
                onChanged: (value) {
                  BlocProvider.of<TodoListBloc>(context).add(TodoListEdited(
                      todoInfo: data.copyWith(isChecked: !data.isChecked)));
                }),
            Expanded(child: _buildTitle()),
            PopupMenuButton(
              child: const Icon(
                Icons.more_vert_rounded,
                size: AppSize.s20,
              ),
              itemBuilder: (_) => <PopupMenuItem<TodoAction>>[
                PopupMenuItem<TodoAction>(
                    value: TodoAction.edit,
                    child: Text(
                      AppStrings.edit,
                      style:
                          getMediumStyle(color: Theme.of(context).primaryColor),
                    )),
                PopupMenuItem<TodoAction>(
                    value: TodoAction.delete,
                    child: Text(AppStrings.delete,
                        style: getMediumStyle(
                            color: Theme.of(context).primaryColor))),
              ],
              onSelected: (TodoAction value) {
                _onClickMore(context, value);
              },
            )
          ],
        ),
      ),
    );
  }

  void _onClickMore(BuildContext context, TodoAction action) {
    switch (action) {
      case TodoAction.delete:
        {
          onDeleteAction(context);
          break;
        }
      case TodoAction.edit:
        {
          onEditAction(context);
          break;
        }
      default:
        {
          break;
        }
    }
  }

  Widget _buildTitle() {
    return Text(data.content);
  }

  void onDeleteAction(BuildContext context) {
    final id = data.id;
    if (id != null) {
      displayDialogTwoAction(context,
          title: AppStrings.alert,
          message: AppStrings.titleDeleteNote,
          titleActionRight: AppStrings.cancel,
          titleActionLeft: AppStrings.agree, actionLeft: () {
        BlocProvider.of<TodoListBloc>(context).add(TodoListRemoved(id: id));
        Navigator.pop(context);
      }, actionRight: () {
        Navigator.pop(context);
      });
    }
  }

  void onEditAction(BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();
    textFieldController.text = data.content;
    textFieldController.selection = TextSelection.fromPosition(
        TextPosition(offset: textFieldController.text.length));
    var todoForEditing = data.copyWith();
    displayTextInputDialog(context,
        title: AppStrings.createNewTodo,
        titleActionLeft: AppStrings.cancel,
        titleActionRight: AppStrings.ok,
        actionAgree: () {
          context
              .read<TodoListBloc>()
              .add(TodoListEdited(todoInfo: todoForEditing));
          Navigator.pop(context);
        },
        actionDegree: () {
          Navigator.pop(context);
        },
        hintText: AppStrings.pleaseInputYourTodo,
        onChange: (value) {
          todoForEditing = data.copyWith(content: value);
        },
        textFieldController: textFieldController);
  }
}
