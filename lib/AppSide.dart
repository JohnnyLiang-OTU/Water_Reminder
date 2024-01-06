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
  bool isSwitched = false;
  int intervalInMinutes = 5;
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
  // @override
  // // Widget build(BuildContext context) {
  // //   return Scaffold(
  // //     appBar: AppBar(
  // //       title: Text('Simple Flutter App'),
  // //       actions: [
  // //         IconButton(onPressed: stopNotification, icon: const Icon(Icons.cancel)),
  // //       ],
  // //     ),
  // //     floatingActionButton: FloatingActionButton(
  // //       onPressed: scheduleNotification,
  // //       child: const Icon(Icons.notification_add),
  // //     ),
  // //     );
  // // }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bombo"),
        actions: [
          IconButton(
              onPressed: openSettings,
              icon: Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isSwitched = !isSwitched;
            });
            if(isSwitched)
              {
                scheduleNotification();
              }
            else
              {
                stopNotification();
              }
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSwitched ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  isSwitched ? 'ON' : 'OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ************************************** WIDGETS ****************************************
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _minutesController = TextEditingController();
  Widget SettingScreen()
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Hours',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _minutesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Minutes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Validate and handle the input
                _handleInput();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleInput()
  {

  }

  void openSettings()
  {
    Navigator.push(
      context,
        MaterialPageRoute(
        builder: (context) => SettingScreen(),
        ));
  }



  // *********************************** NOTIFICATIONS **********************************
  void stopNotification()
  {
    final AwesomeNotifications awesome = AwesomeNotifications();
    try{
      log("Cancelled all Schedules");
      awesome.cancelAllSchedules();
    }
    catch(e){
      log("Error:",
          error: e);
    }
  }


  Future<bool> scheduleNotification() async
  {
    final AwesomeNotifications awesome = AwesomeNotifications();
    log("Scheduled Activated");
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