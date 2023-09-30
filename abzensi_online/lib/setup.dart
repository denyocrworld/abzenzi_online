import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/firebase_options.dart';
import 'package:hyper_ui/service/local_data_service/local_data_service.dart';
import 'package:hyper_ui/service/notification_service/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

Future initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalDataService.init();

  if (!kIsWeb && Platform.isWindows) return;
}
