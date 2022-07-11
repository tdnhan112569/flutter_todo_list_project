import 'package:test/test.dart';
import 'package:todo_list_project/data/model/todo_info.dart';

void main() {
  group('Todo Info Model', () {
    test(
        'Compare between two todo information, the first is create by constructor, the second is clone by copyWith method without passing any value to argument, must be equal',
        () {
      TodoInfo todoInfo1 = const TodoInfo("Write Unit Test", false);
      TodoInfo todoInfo2 = todoInfo1.copyWith();
      expect(todoInfo2, todoInfo1);
    });

    test('Check parse data form Map', () {
      TodoInfo todoInfo1 = TodoInfo.fromMap(
          const {"id": 1, "content": "Write Unit Test", "isChecked": true});
      TodoInfo todoInfo2 = const TodoInfo("Write Unit Test", true, id: 1);
      expect(todoInfo2, todoInfo1);
    });

    test('Check parse model to Map', () {
      const mapInput = {
        "id": 1,
        "content": "Write Unit Test",
        "isChecked": true
      };
      TodoInfo todoInfo1 = TodoInfo.fromMap(mapInput);
      expect(todoInfo1.toMap(), mapInput);
    });
  });
}
