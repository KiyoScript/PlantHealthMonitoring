import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class LightPage extends StatefulWidget {
  const LightPage({super.key});

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  final _future = Supabase.instance.client.from('LightLevel').select().order('id', ascending: false).limit(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final lights = snapshot.data!;
          return Center(
            child:
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: Svg(
                    'assets/gardening.svg',
                  ),
                alignment: Alignment.bottomLeft,
                ),
              ),
                child: Center(
                  child: ListView.builder(
                    itemCount: lights.length,
                    itemBuilder: ((context, index) {
                      final light = lights[index];
                      final double lightLevel = light['Llevel'] / 100.0;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 60),
                            const SizedBox(height: 60),
                            const SizedBox(height: 60),
                            const SizedBox(height: 5),
                            const Text(
                              'Light Level',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
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
                                        value: lightLevel, // Set the value here
                                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                        backgroundColor: const Color.fromARGB(255, 174, 185, 174),
                                        strokeWidth: 10,
                                        strokeCap: StrokeCap.round,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${light['Llevel']}%',
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
