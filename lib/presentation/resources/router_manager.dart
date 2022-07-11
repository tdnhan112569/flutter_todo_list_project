import 'package:flutter/material.dart';

import '../screen/dashboard/dashboard_view.dart';
import 'string_manager.dart';

class Routes {
  static const String dashboard = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.dashboard:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
