import 'package:flutter/material.dart';
import 'location_page.dart';

class GenderPage extends StatelessWidget {
  final String uid;
  final String bloodGroup;

  const GenderPage({Key? key, required this.uid, required this.bloodGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Set background color to red
      appBar: AppBar(
        title: const Text("Choose Gender"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Your Gender",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildGenderButton(context, "Male"),
            const SizedBox(height: 15),
            _buildGenderButton(context, "Female"),
            const SizedBox(height: 15),
            _buildGenderButton(context, "Other"),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(BuildContext context, String gender) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationPage(uid: uid, bloodGroup: bloodGroup, gender: gender)),
        );
      },
      child: Text(
        gender,
        style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
