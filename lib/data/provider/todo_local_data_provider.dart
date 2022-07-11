import 'package:todo_list_project/db/todo/todo_db.dart';

import '../../db/model/ob/todo/todo_object_box.dart';

class TodoLocalDataProvider extends TodoDBContext<TodoOB> {
  final TodoDBContext<TodoOB> todoDBContext;

  TodoLocalDataProvider({required this.todoDBContext});

  @override
  bool delete(int id) => todoDBContext.delete(id);

  @override
  bool edit(TodoOB todoEntity) => todoDBContext.edit(todoEntity);

  @override
  Future<List<TodoOB>> read() {
    // TODO: implement read
    return todoDBContext.read();
  }

  @override
  bool insert(TodoOB todoEntity) => todoDBContext.insert(todoEntity);
}
