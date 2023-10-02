import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hyper_ui/main.dart';
import 'package:path_provider/path_provider.dart';
import '../../core.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Handling a background message ${message.messageId}');
}

@pragma('vm:entry-point')
void notificationTapBackground(
    NotificationResponse notificationResponse) async {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }

  print("id: ${notificationResponse.id}");
  print("actionId: ${notificationResponse.actionId}");
  print("payload: ${notificationResponse.payload}");
  print("input: ${notificationResponse.input}");
  print(
    "notificationResponseType: ${notificationResponse.notificationResponseType}",
  );

  // if (Get.currentContext == null) {
  //   await main();
  // }
  Get.to(EmployeeAttendanceFormView());
}

class NotificationService {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static late AndroidNotificationChannel channel;
  static bool isFlutterLocalNotificationsInitialized = false;
  initNotifications() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      showFlutterNotification(remoteMessage);
    });
    if (!kIsWeb) {
      await setupFlutterNotifications();
    }
  }

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            'BNKkaUWxyP_yC_lki1kYazgca0TNhuzt2drsOrL6WrgGbqnMnr8ZMLzg_rSPDm6HKphABS0KzjPfSqCXHXEd06Y');
    print("FCM Token: $token");
    await saveToken(token!);
    return token;
  }

  int get notificationId {
    DateTime now = DateTime.now();
    int timestamp = now.microsecondsSinceEpoch;
    int maxId = 999999;
    int uniqueId = timestamp % (maxId + 1);
    return uniqueId;
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
      ),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final Dio dio = Dio();
    try {
      final Response<List<int>> response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data!);
      } else {
        throw Exception('Failed to get byte array: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void showFlutterNotification(RemoteMessage message) async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl('https://dummyimage.com/48x48'),
    );

    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl(
        'https://images.unsplash.com/photo-1504639725590-34d0984388bd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80',
      ),
    );

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      bigPicture,
      largeIcon: largeIcon,
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );

    final String bigPicturePath = await _downloadAndSaveFile(
      'https://dummyimage.com/600x200',
      'bigPicture.jpg',
    );

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
            largeIcon: FilePathAndroidBitmap(bigPicturePath),
            styleInformation: bigPictureStyleInformation,
            actions: <AndroidNotificationAction>[
              AndroidNotificationAction(
                'text_id_1',
                'Enter Text',
                icon: DrawableResourceAndroidBitmap('app_icon'),
                inputs: <AndroidNotificationActionInput>[
                  AndroidNotificationActionInput(
                    label: 'Enter a message',
                  ),
                ],
              ),
              AndroidNotificationAction(
                'action_yes_id',
                'Yes',
                icon: DrawableResourceAndroidBitmap('app_icon'),
                contextual: true,
              ),
              AndroidNotificationAction(
                'action_no_id',
                'No',
                titleColor: Color.fromARGB(255, 255, 0, 0),
                icon: DrawableResourceAndroidBitmap('app_icon'),
              ),
              AndroidNotificationAction(
                'action_cancel_id',
                'Cancel',
                icon: DrawableResourceAndroidBitmap('app_icon'),
                showsUserInterface: true,
                cancelNotification: false,
              ),
            ],
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<Uint8List> getByteArrayFromUrl(String url) async {
    final response = await Dio().get(url);
    return response.data;
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Dio dio = Dio();
    try {
      final Response<List<int>> response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        final List<int> bytes = response.data!;
        final File file = File(filePath);
        await file.writeAsBytes(bytes);
        return filePath;
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  saveToken(String fcmToken) async {
    await Dio().post(
      "${Env.baseUrl}/api/tokens",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
      data: {
        "token": fcmToken,
      },
    );
  }
}
