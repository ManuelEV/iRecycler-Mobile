import 'package:flutter/material.dart';
import 'package:irecycler_mobile/models/user.dart';
import 'package:irecycler_mobile/services/auth.dart';
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
        ));
    /*return MaterialApp(
      initialRoute: HomePage.routeName,
      routes: getRoutes()
    );*/
  }
}
