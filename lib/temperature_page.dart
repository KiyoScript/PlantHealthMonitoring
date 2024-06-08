import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  late Timer _timer;
  late Stream<List<dynamic>> _temphumidStream;


  @override
  void initState() {
    super.initState();
    _temphumidStream = _fetchTemphumid();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _temphumidStream = _fetchTemphumid();
      });
    });
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  Stream<List<dynamic>> _fetchTemphumid() {
    return Supabase.instance.client
      .from('TempHumidLevel')
      .stream(primaryKey: ['id'])
      .order('id', ascending: false)
      .limit(20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _temphumidStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 6,
                strokeAlign: 4,
                color: Colors.green,
              ),
            );
          }
          final data = snapshot.data!;

          return Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: Svg(
                    'assets/gardening.svg',
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final item = data[index];
                    final temperatureLevel = item['Tlevel'];
                    final humidityLevel = item['Hlevel'];
                    String formattedDateTime = DateFormat('MMM dd, yyyy (hh:mm a)')
                        .format(DateTime.parse(item['created_at']).toLocal());

                    IconData iconData;
                    Color iconColor;
                    String title;

                    if (temperatureLevel < 20.0) {
                      iconData = Icons.ac_unit;
                      iconColor = Colors.blue;
                      title = 'Low Temperature';
                    } else if (temperatureLevel > 30.0) {
                      iconData = Icons.wb_sunny;
                      iconColor = Colors.orange;
                      title = 'High Temperature';
                    } else {
                      iconData = Icons.thermostat;
                      iconColor = Colors.green;
                      title = 'Temperature';
                    }

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: iconColor,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Temperature: ${temperatureLevel.toStringAsFixed(2)}°C\nHumidity: ${humidityLevel.toStringAsFixed(2)}%',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    formattedDateTime,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                iconData,
                                color: iconColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
