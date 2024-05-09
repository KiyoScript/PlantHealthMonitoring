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
        backgroundColor: const Color.fromARGB(255, 231, 248, 232),
        appBar: AppBar(
          leading: const Icon(Icons.energy_savings_leaf, color: Colors.white),
          title: const Text('Plant Health Monitoring App',
          style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
          body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(
                'Moisture Level', // Replace with the actual percentage text
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 200, // Set the width to make it bigger
                height: 200, // Set the height to make it bigger
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 200, // Set the width of CircularProgressIndicator
                        height: 200, // Set the height of CircularProgressIndicator
                        child: CircularProgressIndicator(
                          value: .3, // Replace with the actual percentage value
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          backgroundColor: Colors.white,
                          strokeWidth: 10,
                          strokeCap: StrokeCap.round
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '30%', // Replace with the actual percentage text
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                 icon: Icons.sunny_snowing,
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
