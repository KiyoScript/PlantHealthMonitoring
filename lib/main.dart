import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dashboard_page.dart';
import 'moisture_page.dart';
import 'temperature_page.dart';
import 'light_page.dart';
import 'about_page.dart';

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
  bool _isLoading = false;

  final List<Widget> _pages = [
    const DashboardPage(),
    const MoisturePage(),
    const TemperaturePage(),
    const LightPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 232, 250, 232)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plant Health Monitoring App', style: TextStyle(color: Colors.green)),
          leading: Image.asset('assets/logo.png'),
          titleSpacing: 16.0,
          backgroundColor: const Color.fromARGB(255, 232, 250, 232),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  color: Colors.green,
                  icon: const Icon(Icons.question_mark_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: _isLoading ? const Center(child: CircularProgressIndicator(strokeWidth: 6, strokeAlign:4, color: Colors.green )) : _pages[_pageIndex],
        bottomNavigationBar: ClipRect(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [BoxShadow(color: Colors.green, spreadRadius: 0, blurRadius: 20)],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: GNav(
                backgroundColor: Colors.green,
                color: Colors.white,
                activeColor: Colors.green,
                tabBackgroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                gap: 8,
                tabs: [
                  GButton(
                    icon: Icons.dashboard_sharp,
                    text: 'Dashboard',
                    onPressed: () {
                      setState(() {
                        _pageIndex = 0;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.water_drop_sharp,
                    text: 'Moisture',
                    onPressed: () {
                      setState(() {
                        _pageIndex = 1;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.thermostat_sharp,
                    text: 'Temperature',
                    onPressed: () {
                      setState(() {
                        _pageIndex = 2;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.sunny_snowing,
                    text: 'Light',
                    onPressed: () {
                      setState(() {
                        _pageIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
