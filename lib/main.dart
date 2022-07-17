import 'package:ecommercefood/src/modules/controller/state_controller.dart';
import 'package:ecommercefood/src/modules/services/firebase_messaging_service.dart';
import 'package:ecommercefood/src/modules/services/notification_service.dart';
import 'package:ecommercefood/src/shared/firebase/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppFirebase());
}


