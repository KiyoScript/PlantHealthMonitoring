import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final _temphumid = Supabase.instance.client
      .from('TempHumidLevel')
      .select()
      .order('id', ascending: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _temphumid,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
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
                    final double temperatureLevel = item['Tlevel'];
                    final double humidityLevel = item['Hlevel'];

                    IconData iconData;
                    Color iconColor;
                    String title;

                    // Adjusting the title and icon based on temperature level
                    if (temperatureLevel < 15.0) {
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
                                    '${item['created_at']}',
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
