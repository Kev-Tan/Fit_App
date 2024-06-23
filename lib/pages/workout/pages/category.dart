import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fit_app/models/user_provider.dart';

class CategoryPage extends StatefulWidget {
  final UserProvider userProvider;
  final String category;

  const CategoryPage({
    Key? key,
    required this.userProvider,
    required this.category,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isLoading = false;
  List<dynamic> exercisesData = [];

  @override
  void initState() {
    super.initState();
    // Fetch data immediately when the page is loaded
    fetchData();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });

    var headers = {
      'X-RapidAPI-Key': '7ab947740cmshd323f3c44a46163p15f232jsnaa7e65139c2a',
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    };

    var uri = Uri.https(
      'exercisedb.p.rapidapi.com',
      '/exercises/bodyPart/${widget.category}',
      {'limit': '50'}, // Adjust limit as per your requirement
    );

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        exercisesData = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(
            fontSize: 24.0,
            color: Color(0xFF00008B),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  const SizedBox(height: 10),
                  // You can add TextFields and buttons here if needed
                  const SizedBox(height: 10),
                  // Display exercise details
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: exercisesData.length,
                    itemBuilder: (context, index) {
                      var exercise = exercisesData[index];
                      return ExerciseDetailCard(
                        number: index + 1, // Add numbering
                        exerciseName: exercise['name'],
                        bodyPart: exercise['bodyPart'],
                        target: exercise['target'],
                        equipment: exercise['equipment'],
                        gifUrl: exercise['gifUrl'],
                        instructions: (exercise['instructions'] as List)
                            .cast<String>(), // Cast to List<String>
                        color: index.isEven ? Colors.blue : Colors.pink,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class ExerciseDetailCard extends StatelessWidget {
  final int number;
  final String exerciseName;
  final String bodyPart;
  final String target;
  final String equipment;
  final String gifUrl;
  final List<String> instructions;
  final Color color;

  const ExerciseDetailCard({
    Key? key,
    required this.number,
    required this.exerciseName,
    required this.bodyPart,
    required this.target,
    required this.equipment,
    required this.gifUrl,
    required this.instructions,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number. Exercise Name: $exerciseName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Body Part: $bodyPart'),
            Text('Target: $target'),
            Text('Equipment: $equipment'),
            SizedBox(height: 8),
            Image.network(
              gifUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: instructions
                  .map((instruction) => Text(' - $instruction'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
