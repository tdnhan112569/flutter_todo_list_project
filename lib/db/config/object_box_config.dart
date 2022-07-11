import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_project/db/model/ob/todo/objectbox.g.dart';

abstract class ObjectBoxConfig {
  static late Store store;
  static bool _isInitStore = false;
  static late String path;

  static initOB({String? path}) async {
    final String dir;
    if (path != null) {
      dir = '$path/ob';
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      dir = '${appDir.path}/ob';
    }
    store = Store(getObjectBoxModel(), directory: dir);
    _isInitStore = true;
  }

  Box<M>? getBox<M>() {
    if (_isInitStore) {
      return store.box<M>();
    }
    return null;
  }

  static close() {
    if (_isInitStore) {
      store.close();
    }
  }

  void initBox();
}
