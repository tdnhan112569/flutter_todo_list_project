import 'package:todo_list_project/data/provider/todo_local_data_provider.dart';
import 'package:todo_list_project/domain/mapper/todo/todo_mapper.dart';

import '../../data/model/todo_info.dart';

class TodoRepository {
  final TodoLocalDataProvider todoLocalDataProvider;
  final mapper = TodoMapper();
  TodoRepository({required this.todoLocalDataProvider});

  Future<List<TodoInfo>> fetchTodoInfo() async {
    try {
      final list = await todoLocalDataProvider.read();
      list.sort((a, b) {
        if (a.id > b.id) return -1;
        if (a.id < b.id) return 1;
        return 0;
      });
      return list.map((e) => mapper.mapToViewModel(e)).toList();
    } catch (ex) {
      return [];
    }
  }

  bool insert(TodoInfo todoInfo) {
    return todoLocalDataProvider.insert(mapper.mapToDataProvider(todoInfo));
  }

  bool edit(TodoInfo todoInfo) {
    return todoLocalDataProvider.edit(mapper.mapToDataProvider(todoInfo));
  }

  bool remove(int id) {
    return todoLocalDataProvider.delete(id);
  }
}
