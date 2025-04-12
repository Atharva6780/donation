import 'package:flutter/material.dart';
import 'gender_page.dart';

class BloodGroupPage extends StatelessWidget {
  final String uid;

  const BloodGroupPage({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Set background color to red
      appBar: AppBar(
        title: const Text("Choose Blood Group"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Your Blood Group",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                _buildBloodGroupButton(context, "A+"),
                _buildBloodGroupButton(context, "A-"),
                _buildBloodGroupButton(context, "B+"),
                _buildBloodGroupButton(context, "B-"),
                _buildBloodGroupButton(context, "O+"),
                _buildBloodGroupButton(context, "O-"),
                _buildBloodGroupButton(context, "AB+"),
                _buildBloodGroupButton(context, "AB-"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBloodGroupButton(BuildContext context, String bloodGroup) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GenderPage(uid: uid, bloodGroup: bloodGroup)),
        );
      },
      child: Text(
        bloodGroup,
        style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
