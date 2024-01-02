import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/i_awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/AppSide.dart';

void main() async{
  await AwesomeNotifications().initialize(
  null,
    [
      NotificationChannel(
          channelKey: 'canal1',
          channelName: 'Name',
          channelDescription: 'Notification for app',
          groupKey: 'group')
    ],
    channelGroups: [NotificationChannelGroup(channelGroupKey: 'group', channelGroupName: 'Antena1')]
  );
  bool isAllowedToSendNotif = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotif)
    {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AppSide();
  }
}
