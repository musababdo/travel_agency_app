
import 'package:flightbooking/profile/profilescreen.dart';
import 'package:flightbooking/screens/booked.dart';
import 'package:flightbooking/screens/home.dart';
import 'package:flightbooking/screens/login.dart';
import 'package:flightbooking/screens/mybooked.dart';
import 'package:flightbooking/screens/bookeddetails.dart';
import 'package:flightbooking/screens/register.dart';
import 'package:flightbooking/screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Login.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
          Home.id: (context) => Home(),
          Booked.id: (context) => Booked(),
          ProfileScreen.id: (context) => ProfileScreen(),
          MyBooked.id: (context) => MyBooked(),
          BookedDetails.id: (context) => BookedDetails(),
        },
      );
  }
}
