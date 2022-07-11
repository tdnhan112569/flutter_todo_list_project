import 'package:flutter/material.dart';
import 'package:todo_list_project/db/config/object_box_config.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBoxConfig.initOB();
  runApp(Application());
}
