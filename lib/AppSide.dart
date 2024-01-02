import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/notif_controller.dart';

class AppSide extends StatefulWidget
{
  _AppSideState createState() => _AppSideState();
}

class _AppSideState extends State<AppSide>
{

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismiss,
      onNotificationCreatedMethod: NotificationController.onNotificationCreateMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayMethod
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Flutter App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scheduleNotification,
        child: Icon(Icons.notification_add),
      ),
      );
  }

  Future<bool> scheduleNotification() async
  {
    final AwesomeNotifications awesome = AwesomeNotifications();
    return await awesome.createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'canal1',
          title: 'Hi',
          body: 'Bombo'
        ),
      // schedule: NotificationCalendar(
      //   year: DateTime.now().year,
      //   month: DateTime.now().month,
      //   day: DateTime.now().day,
      //   hour: DateTime.now().hour,
      //   minute: DateTime.now().minute + 1,
      //   preciseAlarm: true,
      //   allowWhileIdle: true
      schedule: NotificationInterval(
        interval: 60,
        timeZone: 'America/Panama',
        repeats: true,
        preciseAlarm: true,
        allowWhileIdle: true
      )
    );
  }

}