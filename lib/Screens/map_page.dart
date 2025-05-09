import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  List<dynamic> _Hospitals = [];
  bool _loading = true;
  String apiKey = "7jyHdLGG6iGv1aAsIALHAJVoLyaEJX4E";

  @override
  void initState() {
    super.initState();
    _loadCachedData();
  }

  Future<void> _loadCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString("hospital");

    if (cachedData != null) {
      setState(() {
        _Hospitals = json.decode(cachedData);
        _loading = false;
      });
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Location permission denied");
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    _fetchNearbyHospitals(position.latitude, position.longitude);
  }

  Future<void> _fetchNearbyHospitals(double lat, double lon) async {
    String url = "https://api.tomtom.com/search/2/nearbySearch/.json?key=$apiKey&lat=$lat&lon=$lon&radius=5000&categorySet=7321";
        // "https://api.tomtom.com/search/2/search/hospital.json?key=$apiKey&countrySet=IN&limit=10";
        
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("API Response: $data");

      setState(() {
        _Hospitals = data["results"];
        _loading = false;
      });

      // Save response to cache
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("hospital", json.encode(_Hospitals));
    } else {
      print("Error fetching Hospitals: ${response.statusCode}");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Hospitals"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _loading = true;
              });
              _getCurrentLocation();
            },
          )
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _Hospitals.isEmpty
              ? Center(child: Text("No Hospitals found"))
              : ListView.builder(
                  itemCount: _Hospitals.length,
                  itemBuilder: (context, index) {
                    var station = _Hospitals[index];
                    String name = station["poi"]["name"] ?? "Hospitals";
                    String address =
                        station["address"]["freeformAddress"] ?? "No Address";

                    return Card(
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text(address),
                        leading:
                            Icon(Icons.local_gas_station, color: Colors.red),
                      ),
                    );
                  },
                ),
    );
  }
}