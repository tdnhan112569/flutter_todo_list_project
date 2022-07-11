import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_project/data/model/todo_info.dart';
import 'package:todo_list_project/db/model/ob/todo/todo_object_box.dart';
import 'package:todo_list_project/domain/mapper/todo/todo_mapper.dart';

void main() {
  group('Todo mapper', () {
    late TodoMapper mapper;
    setUp(() {
      mapper = TodoMapper();
    });

    test('From TodoInfo to TodoOB', () {
      TodoInfo todoInfo = const TodoInfo("Hello", false, id: 10);
      final todoDbModel = mapper.mapToDataProvider(todoInfo);
      expect(todoDbModel.id, todoInfo.id);
      expect(todoDbModel.content, todoInfo.content);
      expect(todoDbModel.isChecked, todoInfo.isChecked);
    });

    test('From TodoOB to TodoInfo', () {
      TodoOB todoOB = TodoOB(content: "Hello", isChecked: true, id: 1);
      final todoInfo = mapper.mapToViewModel(todoOB);
      expect(todoInfo.id, todoOB.id);
      expect(todoInfo.content, todoOB.content);
      expect(todoInfo.isChecked, todoOB.isChecked);
    });
  });
}
