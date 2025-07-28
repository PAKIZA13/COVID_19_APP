import 'package:flutter/material.dart';
import 'package:covid_19_app/views/world_state_row.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final int totalcase;
  final int totaldeath;
  final int totalrecovered;
  final int active;
  final int critical;
  final int todaycase;
  final int todaydeath;
  final int todayRecovered;
  final int test;

  const DetailScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.totalcase,
    required this.totaldeath,
    required this.totalrecovered,
    required this.active,
    required this.critical,
    required this.todaycase,
    required this.todaydeath,
    required this.todayRecovered,
    required this.test,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.08),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
                      child: Column(
                        children: [
                          WorldStateRow(title: "Cases", value: widget.totalcase.toString()),
                          WorldStateRow(title: "Recovered", value: widget.totalrecovered.toString()),
                          WorldStateRow(title: "Deaths", value: widget.totaldeath.toString()),
                          WorldStateRow(title: "Active", value: widget.active.toString()),
                          WorldStateRow(title: "Critical", value: widget.critical.toString()),
                          WorldStateRow(title: "Today Cases", value: widget.todaycase.toString()),
                          WorldStateRow(title: "Today Deaths", value: widget.todaydeath.toString()),
                          WorldStateRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                          WorldStateRow(title: "Tests", value: widget.test.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
