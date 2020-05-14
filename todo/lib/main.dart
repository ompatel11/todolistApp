import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screens/add_task.dart';
import 'package:todo/home/home.dart';
import 'package:todo/services/auth.dart';
import 'app.dart';
import 'package:todo/models/user.dart';
void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp(
          theme: ThemeData.dark(),
          routes: {
            '/new_task': (context) => Add_task(),
            '/home':(context) => DefaultScreen(),
          },
        debugShowCheckedModeBanner: false,
        home:  Wrapper(),
      ),
    );
  }
}