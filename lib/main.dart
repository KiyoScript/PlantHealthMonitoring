import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'moisture_page.dart';
import 'temperature_page.dart';
import 'light_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supabaseUrl,anonKey: supabaseKey);
  runApp(const MainApp());
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const MoisturePage(),
    const TemperaturePage(),
    const LightPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: const Text('Plant Health Monitoring App', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('About Us'),
                leading: const Icon(Icons.info),
                onTap: () {
                  // Add your about us functionality here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Exit'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: _pages[_pageIndex],

        bottomNavigationBar: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: GNav(
                backgroundColor: Colors.green,
                color: Colors.white,
                activeColor: Colors.green,
                tabBackgroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                gap: 8,
                tabs: [
                  GButton(
                    icon: Icons.water_drop_outlined,
                    text: 'Moisture',
                    onPressed: () {
                      setState(() {
                        _pageIndex = 0;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.thermostat,
                    text: 'Temperature',
                    onPressed: () {
                      setState(() {
                        _pageIndex = 1;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.sunny_snowing,
                    text: 'Light',
                    onPressed: () {
                      setState(() {
                        _pageIndex = 2;
                      });
                    },
                  ),
                ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.rotate_left_rounded, color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false
    );
  }
}

