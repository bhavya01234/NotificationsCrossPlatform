
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notif/message.dart';

class NotificationServices{
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance ;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();


  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings ,
        iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
        onDidReceiveNotificationResponse: (payload){
          // handle interaction when app is active for android
          handleMessage(context, message);
        }
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      //shows notif
      alert: true,
      //sim reads notif:
      announcement: true,
      //app icon indicator on notif:
      badge: true,
      //
      carPlay: true,
      criticalAlert: true,
      //grants perms in frontend
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // if (kDebugMode) {
        print('user granted permission');
      // }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // if (kDebugMode) {
        print('user granted provisional permission');
      // }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      // if (kDebugMode) {
        print('user denied permission');
      // }
    }
  }



  // void firebaseInit(){
  //   FirebaseMessaging.onMessage.listen((message) {
  //
  //     if(kDebugMode){
  //       print(message.notification!.title.toString());
  //       print(message.notification!.body.toString());
  //     }
  //     showNotification(message);
  //   });
  // }
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      print('inside firebaseInit fnc');
      print(message.data.toString());
      print(message.data['type']);
      print(message.data['id']);
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }else{
        showNotification(message);
      }
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        // message.notification!.android!.channelId.toString(),
        // message.notification!.android!.channelId.toString() ,
        //Random.secure().nextInt(100000).toString(),
      'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max  ,
        // showBadge: true ,
        // playSound: true,
        // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString() ,
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high ,
        // playSound: true,
        ticker: 'ticker' ,
        // sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true ,
        presentBadge: true ,
        presentSound: true
    ) ;

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero , (){
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails ,
      );
    });

  }


  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      // if (kDebugMode) {
        print('refresh');
      // }
    });
  }


  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }


  void handleMessage(BuildContext context, RemoteMessage message) {

    if(message.data['type'] =='msj'){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MessageScreen(
            id: message.data['id'] ,
          )));
    }
  }

}