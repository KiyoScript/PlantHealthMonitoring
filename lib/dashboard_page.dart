import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<List<dynamic>> _fetchData() async {
    final moisture = await Supabase.instance.client
        .from('MoistureLevel')
        .select()
        .order('id', ascending: false)
        .limit(1);

    final light = await Supabase.instance.client
        .from('LightLevel')
        .select()
        .order('id', ascending: false)
        .limit(1);

    final temphumid = await Supabase.instance.client
        .from('TempHumidLevel')
        .select()
        .order('id', ascending: false)
        .limit(1);

    return [moisture, light, temphumid];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 6, strokeAlign:4, color: Colors.green ));
          }
          final data = snapshot.data!;
          final moisture = data[0].isNotEmpty ? data[0][0] : {'Mlevel': 0};
          final light = data[1].isNotEmpty ? data[1][0] : {'Llevel': 0};
          final temperature = data[2].isNotEmpty ? data[2][0] : {'Tlevel': 0};
          final humidity = data[2].isNotEmpty ? data[2][0] : {'Hlevel': 0};

          return Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: Svg('assets/gardening.svg'),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildContainer(
                    title: 'Moisture Level',
                    value: '${moisture['Mlevel']}%',
                    valueColor: moisture['Mlevel'] < 50.0 ? Colors.red : Colors.green,
                    circularValue: moisture['Mlevel'] / 100.0,
                  ),
                  _buildContainer(
                    title: 'Light Level',
                    value: '${light['Llevel']} lx',
                    valueColor: light['Llevel'] < 300 ? Colors.red : Colors.green,
                    circularValue: light['Llevel'] / 1000.0,
                  ),
                  _buildContainer(
                    title: 'Temperature Level',
                    value: '${temperature['Tlevel']}°C',
                    valueColor: temperature['Tlevel'] < 30 ? Colors.blue : Colors.red,
                    circularValue: temperature['Tlevel'] / 100.0,
                  ),
                  _buildContainer(
                    title: 'Humidity Level',
                    value: '${humidity['Hlevel']}%',
                    valueColor: humidity['Hlevel'] < 50 ? Colors.red : Colors.green,
                    circularValue: humidity['Hlevel'] / 100.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContainer({required String title, required String value, required Color valueColor, required double circularValue}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SizedBox(
              width: 70,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  CircularProgressIndicator(
                    value: circularValue,
                    valueColor: AlwaysStoppedAnimation<Color>(valueColor),
                    backgroundColor: const Color.fromARGB(255, 189, 234, 191),
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                  ),
                  Center(
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: valueColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
