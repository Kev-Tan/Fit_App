import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/pages/home/widgets/heatmap/heat_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/pages/home/widgets/bar%20graph/bar_graph.dart';


class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Get the count of body parts from the provider
    Map<String, int> bodyPartCounts = userProvider.countBodyParts();
    
    // Create a list from the counts
    List<int> weeklySummary = [
      bodyPartCounts['back'] ?? 0,
      bodyPartCounts['cardio'] ?? 0,
      bodyPartCounts['chest'] ?? 0,
      bodyPartCounts['lower arms'] ?? 0,
      bodyPartCounts['lower legs'] ?? 0,
      bodyPartCounts['neck'] ?? 0,
      bodyPartCounts['shoulders'] ?? 0,
      bodyPartCounts['waist'] ?? 0,
      bodyPartCounts['upper arms'] ?? 0,
      bodyPartCounts['upper legs'] ?? 0,
    ];

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60.0,
            bottom: 30.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 70.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 275,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: MyHeatMap(
                              userProvider: userProvider,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            height: 275,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.0,
                              ),
                            ),
                            child: Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                                List<String> exerciseNames = userProvider.exercises.map((exercise) => exercise['name'] as String).toList();

                                return ListView.builder(
                                  itemCount: exerciseNames.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        exerciseNames[index],
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: MyBarGraph(
                        weeklySummary: weeklySummary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBarGraph extends StatelessWidget {
  final List<int> weeklySummary;

  const MyBarGraph({required this.weeklySummary, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyPartLabels = [
      'Back',
      'Cardio',
      'Chest',
      'Lower Arms',
      'Lower Legs',
      'Neck',
      'Shoulders',
      'Waist',
      'Upper Arms',
      'Upper Legs'
    ];

    return BarChart(
      data: weeklySummary,
      labels: bodyPartLabels,
    );
  }
}

class BarChart extends StatelessWidget {
  final List<int> data;
  final List<String> labels;

  const BarChart({required this.data, required this.labels, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: data.asMap().entries.map((entry) {
        return Column(
          children: [
            Text('${entry.value}'),
            Container(
              height: entry.value.toDouble() * 10,
              width: 20,
              color: Colors.blue,
            ),
            Text(labels[entry.key]),
          ],
        );
      }).toList(),
    );
  }
}