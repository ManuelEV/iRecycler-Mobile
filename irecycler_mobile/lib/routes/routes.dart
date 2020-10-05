import 'package:flutter/material.dart';
import 'package:irecycler_mobile/screens/add_point_screen.dart';
import 'package:irecycler_mobile/screens/home.dart';
import 'package:irecycler_mobile/screens/my_points_screen.dart';
import 'package:irecycler_mobile/screens/points_on_map_screen.dart';
import 'package:irecycler_mobile/screens/select_point_map_screen.dart';


Map<String, WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    AddPointScreen.routeName: (context) => AddPointScreen(),
    PointOnMapScreen.routeName: (context) => PointOnMapScreen(),
    MapScreen.routeName: (context) => MapScreen(),
    HomePage.routeName: (context) => HomePage(),
    MyPointsScreen.routeName: (context) => MyPointsScreen(),
    //Wrapper.routeName: (context) => HomePage(),
  };
}