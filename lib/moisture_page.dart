import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';

class MoisturePage extends StatefulWidget {
  const MoisturePage({super.key});

  @override
  State<MoisturePage> createState() => _MoisturePageState();
}

class _MoisturePageState extends State<MoisturePage> {
  final _moistures = Supabase.instance.client.from('MoistureLevel').select().order('id', ascending: false).limit(20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _moistures,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 6, strokeAlign:4, color: Colors.green ));
          }
          final moistures = snapshot.data!;

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
                  itemCount: moistures.length,
                  itemBuilder: ((context, index) {
                    final moisture = moistures[index];
                    String formattedDateTime = DateFormat('MMM dd, yyyy (hh:mm a)').format(DateTime.parse(moisture['created_at']).toLocal());
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
                                moisture['Mlevel'] < 30.0 ? 'Low Moisture Level' : 'Moisture Level',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: moisture['Mlevel'] < 50.0 ? Colors.red : Colors.green,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${moisture['Mlevel']}%',
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
                                moisture['Mlevel'] < 30.0 ? Icons.warning : Icons.water_drop,
                                color: moisture['Mlevel'] < 50.0 ? Colors.red : Colors.green,
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
