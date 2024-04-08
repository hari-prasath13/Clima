import 'dart:ffi';
import 'getlocation.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'main.dart';
import 'package:geolocator/geolocator.dart';

class Apibrain extends StatefulWidget {
  @override
  State<Apibrain> createState() => _ApibrainState();
}

class _ApibrainState extends State<Apibrain> {


  @override
  void initState() {
    super.initState();
    // Perform initialization tasks here
    location();
    accessdenided();
  }

  var lattitude;
  var longitude;
  bool access = true;

  Future<void> location() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        access = false;
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      access = false;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position.latitude);
    print(position.longitude);
    lattitude = position.latitude;
    longitude =position.longitude;
  }

    void accessdenided(){
    if (access == false){
      print("denied");
      SnackBar(
        content: Center(child: Text('No Internet Connection!!')),
        duration: Duration(seconds: 5), // Adjust the duration as needed
      );
      }
   }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(primary: Color(0xFF1f1f1f)),
        scaffoldBackgroundColor: Color(0xFF1f1f1f),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'WEATHER APP',
              // Ensure that kapptext is defined somewhere in your code.
              style: kapptext,
            ),
          ),
        ),
        body: Homepage(),
      ),
    );
  }
}

