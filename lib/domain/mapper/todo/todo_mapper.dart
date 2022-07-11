import 'package:todo_list_project/db/model/ob/todo/todo_object_box.dart';

import '../../../data/model/todo_info.dart';
import '../base_mapper.dart';

class TodoMapper extends Mapper<TodoInfo, TodoOB> {
  @override
  TodoOB mapToDataProvider(TodoInfo input) {
    // TODO: implement mapWithDataProvider
    return TodoOB(
        content: input.content, isChecked: input.isChecked, id: input.id ?? 0);
  }

  @override
  TodoInfo mapToViewModel(TodoOB input) {
    // TODO: implement mapWithViewModel
    return TodoInfo(input.content, input.isChecked, id: input.id);
  }
}
