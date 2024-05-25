import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MoisturePage extends StatefulWidget {
  const MoisturePage({super.key});

  @override
  State<MoisturePage> createState() => _MoisturePageState();
}

class _MoisturePageState extends State<MoisturePage> {
  final _future = Supabase.instance.client.from('MoistureLevel').select().order('id', ascending: false).limit(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final moistures = snapshot.data!;
          return Center(
            child:
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: Svg(
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
                      final double moistureLevel = moisture['Mlevel'] / 100.0;

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 60),
                            const SizedBox(height: 60),
                            const SizedBox(height: 60),
                            const SizedBox(height: 5),
                            Text(
                                moisture['Mlevel'] < 30.0 ? 'Low Moisture Level' : 'Moisture Level',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: moisture['Mlevel'] < 50.0 ? Colors.red : Colors.green
                                ),
                              ),
                            const SizedBox(height: 30),
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
                                        value: moistureLevel, // Set the value here
                                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                        backgroundColor: const Color.fromARGB(255, 174, 185, 174),
                                        strokeWidth: 10,
                                        strokeCap: StrokeCap.round,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${moisture['Mlevel']}%',
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                                    ),
                                  ),
                                ],
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
