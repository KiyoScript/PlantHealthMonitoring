import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.green,
          child:  const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
            child:  GNav(
              backgroundColor: Colors.green,
              color: Colors.white,
              activeColor: Colors.green,
              tabBackgroundColor: Colors.white,
              padding: EdgeInsets.all(16),
              gap: 8,
              tabs:  [
                GButton(
                  icon: Icons.water_drop_outlined,
                  text: 'Moisture'
                  ),
                GButton(
                  icon: Icons.thermostat,
                  text: 'Temperature'
                  ),
                GButton(
                 //light icon
                 icon: Icons.light_mode_outlined,
                  text: 'Light'
                ),
              ]
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
