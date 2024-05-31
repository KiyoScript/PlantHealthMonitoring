import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';

class LightPage extends StatefulWidget {
  const LightPage({super.key});

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  final _lights = Supabase.instance.client.from('LightLevel').select().order('id', ascending: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _lights,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final lights = snapshot.data!;

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
                  itemCount: lights.length,
                  itemBuilder: ((context, index) {
                    final light = lights[index];
                    final double lightLevel = light['Llevel'];
                    String formattedDateTime = DateFormat('MMM dd, yyyy (hh:mm a)').format(DateTime.parse(light['created_at']));


                    IconData iconData;
                    Color iconColor;
                    String title;

                    if (lightLevel < 500.0) {
                      iconData = Icons.warning;
                      iconColor = Colors.red;
                      title = 'Low Light Level';
                    } else {
                      iconData = Icons.lightbulb_outline;
                      iconColor = Colors.green;
                      title = 'Light Level';
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
                                    '${lightLevel.toStringAsFixed(2)} lx',
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
