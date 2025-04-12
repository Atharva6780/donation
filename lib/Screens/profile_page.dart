import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  
  ProfilePage({required this.uid});
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  
  @override

  void initState() {
    super.initState();
    getUserData();
  }
  
  Future<void> getUserData() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('client').doc(widget.uid).get();
      
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          backgroundColor: Colors.red,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile_avatar.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userData?['name'] ?? "User", // Display user's name from Firestore
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Blood Group: ${userData?['bloodGroup'] ?? 'B+'}", // You'll need to add this field to your database
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Personal Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text("Email: ${userData?['email'] ?? 'Not specified'}"),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
              title: Text("Phone: ${userData?['mobile'] ?? 'Not specified'}"),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text("Location: ${userData?['location'] ?? 'Mumbai'}"), // You'll need to add this field
            ),
            SizedBox(height: 20),
            Text(
              "Donation History",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.history, color: Colors.red),
              title: Text("Last Donation: ${userData?['lastDonation'] ?? 'No donations yet'}"), // You'll need to add this field
            ),
            ListTile(
              leading: Icon(Icons.date_range, color: Colors.red),
              title: Text("Eligible for Donation: ${userData?['eligibleDate'] ?? 'Not calculated'}"), // You'll need to add this field
            ),
          ],
        ),
      ),
    );
  }
}