import 'package:ecommercefood/src/modules/controller/state_controller.dart';
import 'package:ecommercefood/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StateController>(context);
    
    return MaterialApp(
      title: 'E-commerce Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: Routes.routes,
    );
  }
}
