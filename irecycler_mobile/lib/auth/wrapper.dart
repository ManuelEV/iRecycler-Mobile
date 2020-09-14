import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:irecycler_mobile/models/user.dart';
import 'package:irecycler_mobile/auth/authenticate.dart';
import 'package:irecycler_mobile/screens/home.dart';

class Wrapper extends StatelessWidget {

  static String routeName = '/';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomePage();
    }
    
  }
}