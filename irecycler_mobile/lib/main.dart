import 'package:flutter/material.dart';
import 'package:irecycler_mobile/models/user.dart';
import 'package:irecycler_mobile/routes/routes.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:irecycler_mobile/shared/app_theme.dart';
import 'package:provider/provider.dart';

import 'auth/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: Wrapper.routeName,
        routes: getRoutes()
      )
    );
    /*return MaterialApp(
      initialRoute: HomePage.routeName,
      routes: getRoutes()
    );*/
  }
}
