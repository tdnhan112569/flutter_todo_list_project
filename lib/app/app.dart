import 'package:flutter/material.dart';
import 'package:todo_list_project/db/config/object_box_config.dart';

import '../presentation/resources/router_manager.dart';
import '../presentation/resources/theme_manager.dart';

class Application extends StatefulWidget {
  const Application._internal();
  static const Application instance = Application._internal();
  factory Application() => instance;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.dashboard,
    );
  }

  @override
  void dispose() {
    ObjectBoxConfig.close();
    super.dispose();
  }
}
