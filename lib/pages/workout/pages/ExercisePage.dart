import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _exercises = [];
  final ExerciseService _exerciseService = ExerciseService();

  void _fetchExerciseInfo(String exerciseName) async {
    try {
      List<Map<String, dynamic>> exercises = await _exerciseService.fetchExercises(exerciseName);
      setState(() {
        _exercises = exercises;
      });
    } catch (e) {
      setState(() {
        _exercises = [
          {'error': 'Error: $e'}
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Exercise Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchExerciseInfo(_controller.text);
              },
              child: Text('Fetch Exercise Info'),
            ),
            SizedBox(height: 20),
            _exercises.isEmpty
                ? Text('No exercise data found')
                : Expanded(
                    child: ListView.builder(
                      itemCount: _exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = _exercises[index];
                        if (exercise.containsKey('error')) {
                          return Text(exercise['error'] ?? 'Error');
                        }
                        return ExerciseCard(exercise: exercise);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ExerciseService {
  static const String apiKey = '3f73d91377msh055a1de13a30dcep13e2f0jsnf2d80950f2f9';
  static const String host = 'exercisedb.p.rapidapi.com';

  Future<List<Map<String, dynamic>>> fetchExercises(String exerciseName) async {
    final encodedName = Uri.encodeComponent(exerciseName);
    final url = 'https://exercisedb.p.rapidapi.com/exercises/name/$encodedName?offset=0&limit=10';
    final headers = {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': host,
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return _parseExerciseInfo(response.body);
      } else {
        throw 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }

  List<Map<String, dynamic>> _parseExerciseInfo(String input) {
    List<Map<String, dynamic>> exercises = [];

    // Parse the JSON response
    dynamic jsonData = jsonDecode(input);
    
    // Iterate over the JSON array and extract exercise information
    if (jsonData is List) {
      exercises = jsonData.map((exerciseJson) {
        return {
          'name': exerciseJson['name'],
          'bodyPart': exerciseJson['bodyPart'],
          'gifUrl': exerciseJson['gifUrl'],
          'target': exerciseJson['target'],
          'instructions': exerciseJson['instructions'] != null
              ? List<String>.from(exerciseJson['instructions'])
              : [],
        };
      }).toList();
    }

    return exercises;
  }
}

class ExerciseCard extends StatelessWidget {
  final Map<String, dynamic> exercise;

  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise['name'] ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Body Part: ${exercise['bodyPart'] ?? ''}'),
            Text('Target: ${exercise['target'] ?? ''}'),
            SizedBox(height: 10),
            exercise['gifUrl'] != null && exercise['gifUrl'].isNotEmpty
                ? Image.network(exercise['gifUrl'])
                : SizedBox.shrink(),
            SizedBox(height: 10),
            Text(
              'Instructions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ...?exercise['instructions']?.map(
              (instruction) => Text(instruction),
            ),
          ],
        ),
      ),
    );
  }
}
