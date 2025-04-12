import 'package:flutter/material.dart';
import 'dashboard.dart';

class LocationPage extends StatelessWidget {
  final String uid;
  final String bloodGroup;
  final String gender;

  const LocationPage({Key? key, required this.uid, required this.bloodGroup, required this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController locationController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.red, // Set background color to red
      appBar: AppBar(
        title: const Text("Enter Location"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Your Location",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: "City/Area",
                labelStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard(uid: uid)),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
