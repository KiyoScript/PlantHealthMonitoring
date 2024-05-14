import 'package:flutter/material.dart';

class MoisturePage extends StatelessWidget {
  const MoisturePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Moisture Level',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                        value: .8,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        backgroundColor: Color.fromARGB(255, 174, 185, 174),
                        strokeWidth: 10,
                        strokeCap: StrokeCap.round),
                  ),
                ),
                Center(
                  child: Text(
                    '80%',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
