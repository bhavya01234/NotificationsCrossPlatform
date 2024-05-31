import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notif/notification_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    //notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      // if (kDebugMode) {
        print('device token');
        print(value);
      // }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: Center(
        child: TextButton(onPressed: (){
          notificationServices.getDeviceToken().then((value)async{
            var data = {

              'to' : value.toString(),
              'priority': 'high',
              'notification' : {
                'title' : 'cookie' ,
                'body' : 'Subscribe to my channel' ,
                // "sound": "jetsons_doorbell.mp3"
              },
              // 'android': {
              //   'notification': {
              //     'notification_count': 23,
              //   },
              // },
              // 'data' : {
              //   'type' : 'msj' ,
              //   'id' : 'Asif Taj'
              // }
            };

            await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data) ,
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization' : 'key=AIzaSyB8wjP-HvOYxUjG2k8sHzrATN4KDF0b5xg'
                }
            ).then((value){
              if (kDebugMode) {
                print(value.body.toString());
              }
            }).onError((error, stackTrace){
              if (kDebugMode) {
                print(error.toString());
              }
            });
          });
        }, child: Text('send notif'),),
      ),
    );
  }
}
