import 'package:covid_19_app/services/states_services.dart';
import 'package:covid_19_app/views/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
class CountriesList extends StatefulWidget {
  const CountriesList({super.key});
  @override
  State<CountriesList> createState() => _CountriesListState();
}
class _CountriesListState extends State<CountriesList> {
  StateServices stateServices = StateServices();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onChanged: (text) {
                  setState(() {}); // Rebuild the widget when the search text changes
                },
              ),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: stateServices.countriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                        itemCount: 10, // Display 10 items while loading
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text('Loading...'),
                                subtitle: Text('Loading...'),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    var filteredData = snapshot.data!.where((country) {
                      String name = country['country'].toLowerCase();
                      return name.contains(searchController.text.toLowerCase());
                    }).toList();
                    return ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        var country = filteredData[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          image: country['countryInfo']['flag'],
                                          name: country['country'],
                                          totalcase: country['cases'],
                                          totaldeath: country['deaths'],
                                          totalrecovered: country['recovered'],
                                          active: country['active'],
                                          critical: country['critical'],
                                          todaycase: country['todayCases'],
                                          todaydeath: country['todayDeaths'],
                                          todayRecovered: country['todayRecovered'],
                                          test: country['tests'],
                                        )));
                                ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                        country['countryInfo']['flag']),),
                                  title: Text(country['country']),
                                  subtitle: Text(country['cases'].toString()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
