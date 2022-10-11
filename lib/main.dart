import 'package:flutter/material.dart';
import 'package:front_end_flutter/utils/route/routeGenerator.dart';
import 'package:front_end_flutter/utils/route/routeName.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) => HomePage(child: child ?? const SizedBox()),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RoutesName.LOGIN_PAGE,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey[100],
      ),
      // home: const Login(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Widget child;

  const HomePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
