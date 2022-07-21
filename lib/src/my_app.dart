
import 'package:ecommercefood/src/modules/services/firebase_messaging_service.dart';
import 'package:ecommercefood/src/modules/services/notification_service.dart';
import 'package:ecommercefood/src/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeFirebaseMessaging();
    return MaterialApp(
      title: 'E-commerce Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.SPLASH,
      routes: Routes.routes,
    );
  }

  initializeFirebaseMessaging() async {
    FirebaseMessagingService firebaseMessagingService =
        FirebaseMessagingService(NotificationService());
    await firebaseMessagingService.initialize();
  }
}
