import 'package:flutter/material.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("General Notification", style: TextStyle(fontSize: 20,),),
                const Spacer(),
                Switch(value: true, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("Sound", style: TextStyle(fontSize: 20, ),),
                const Spacer(),
                Switch(value: true, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("Vibrate", style: TextStyle(fontSize: 20, ),),
                const Spacer(),
                Switch(value: false, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("Special Offers", style: TextStyle(fontSize: 20,),),
                const Spacer(),
                Switch(value: true, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("Promo & Discount", style: TextStyle(fontSize: 20,),),
                const Spacer(),
                Switch(value: false, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("Payments", style: TextStyle(fontSize: 20, ),),
                const Spacer(),
                Switch(value: true, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("Cashback", style: TextStyle(fontSize: 20,),),
                const Spacer(),
                Switch(value: false, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("App Updates", style: TextStyle(fontSize: 20, ),),
                const Spacer(),
                Switch(value: true, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("New Service Available", style: TextStyle(fontSize: 20,),),
                const Spacer(),
                Switch(value: false, onChanged: (value) {})
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Text("New Tips Available", style: TextStyle(fontSize: 20, ),),
                const Spacer(),
                Switch(value: false, onChanged: (value) {})
              ],
            ),

          ],
        ),
      ),
    );
  }
}
