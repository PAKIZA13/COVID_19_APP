import 'package:covid_19_app/model/WorldStateModel.dart';
import 'package:covid_19_app/services/states_services.dart';
import 'package:covid_19_app/views/countries_list.dart';
import 'package:covid_19_app/views/world_state_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  final colorList = <Color>[
    const Color(0xff42853F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder<WorldStateModel>(
                future: stateServices.fetchWorldStates(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: controller,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total": double.parse(snapshot.data!.cases!.toString()),
                          "Recovered": double.parse(snapshot.data!.recovered.toString()),
                          "Deaths": double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: colorList,
                        legendOptions: LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              WorldStateRow(title: 'Total', value: snapshot.data!.cases.toString()),
                              WorldStateRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              WorldStateRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              WorldStateRow(title: 'Active', value: snapshot.data!.active.toString()),
                              WorldStateRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              WorldStateRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              WorldStateRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              WorldStateRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          maximumSize: Size(160, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:
                              (context) =>CountriesList()));
                          // Add your onPressed logic here
                        },
                        child: Text(
                          "Track Countries",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
