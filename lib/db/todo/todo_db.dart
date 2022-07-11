import 'package:flutter/foundation.dart';

import '../config/object_box_config.dart';
import '../model/ob/todo/objectbox.g.dart';
import '../model/ob/todo/todo_object_box.dart';

abstract class TodoDBContext<E> {
  Future<List<E>> read();

  bool insert(E todoEntity);

  bool delete(int id);

  bool edit(E todoEntity);
}

class TodoObDB extends TodoDBContext<TodoOB> with ObjectBoxConfig {
  late Box<TodoOB>? box;

  TodoObDB() {
    initBox();
  }

  @override
  bool delete(int id) {
    // TODO: implement delete
    //box?.removeMany([id]);
    try {
      box?.remove(id);
      return true;
    } catch (ex) {
      _printMessage(ex);
      return false;
    }
  }

  @override
  bool edit(TodoOB todoEntity) {
    // TODO: implement edit
    try {
      box?.put(todoEntity, mode: PutMode.update);
      return true;
    } catch (ex) {
      _printMessage(ex);
      return false;
    }
  }

  @override
  bool insert(TodoOB todoEntity) {
    // TODO: implement insert
    try {
      box?.put(todoEntity, mode: PutMode.insert);
      return true;
    } catch (ex) {
      _printMessage(ex);
      return false;
    }
  }

  @override
  Future<List<TodoOB>> read() {
    // TODO: implement read
    if (box == null) {
      initBox();
    }
    try {
      return Future.value(box!.getAll());
    } catch (ex) {
      _printMessage(ex);
      return Future.value([]);
    }
  }

  @override
  void initBox() {
    // TODO: implement initBox
    box = getBox<TodoOB>();
  }

  void _printMessage(Object obj) {
    if (kDebugMode) {
      print("TodoObDB: $obj");
    }
  }
}
