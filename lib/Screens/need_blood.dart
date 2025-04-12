import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'dashboard.dart';
import 'donate.dart'; // Import DonatePage to access donors

class NeedBloodPage extends StatefulWidget {
  final String uid;
  
  const NeedBloodPage({Key? key, required this.uid}) : super(key: key);
  
  @override
  _NeedBloodPageState createState() => _NeedBloodPageState();
}

class _NeedBloodPageState extends State<NeedBloodPage> {
  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print("Could not launch $phoneUri");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the donors list from DonatePage
    final List<Map<String, String>> donors = DonatePage.donors;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to Dashboard with the same UID
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Dashboard(uid: widget.uid)), 
              (Route<dynamic> route) => false
            );
          },
        ),
        title: Text("Available Donors"),
        backgroundColor: Colors.red,
      ),
      body: donors.isEmpty
          ? Center(child: Text("No donors available", style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: donors.length,
              itemBuilder: (context, index) {
                final donor = donors[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.red),
                    title: Text(donor['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Age: ${donor['age']}"),
                        Text("Blood Group: ${donor['bloodGroup']}"),
                        Text("Area: ${donor['area']}"),
                        Text("Contact: ${donor['contact']}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        _makePhoneCall(donor['contact']!);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
