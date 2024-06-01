import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About', style: TextStyle(color: Colors.green)),
        backgroundColor: const Color.fromARGB(255, 232, 250, 232),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Plant Health Monitoring App\nVersion 1.0.0',
              style: TextStyle(fontSize: 18, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            const Text(
              'The Plant Health Monitoring App is designed to help you keep track of the essential parameters '
              'needed for optimal plant growth. By monitoring moisture, temperature, and light levels, this app '
              'ensures your plants receive the best care possible. The intuitive interface and real-time data '
              'updates make it easy to stay informed and take action when it is necessary.',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 60),
            const Text(
              'Development Team:\n'
              '\nJohn Lloyd D. de Sape '
              '\nNathaniel Kate B. Simon '
              '\nArnel A. Jocosol',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            const Spacer(),
            Center(
              child: Text(
                '$currentYear Copyright ©KingMaxx',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
