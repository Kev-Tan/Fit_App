import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fit_app/models/user_provider.dart';

class ExercisePage extends StatefulWidget {
  final UserProvider userProvider;
  const ExercisePage({super.key, required this.userProvider});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _exercises = [];
  final ExerciseService _exerciseService = ExerciseService();

  void _fetchExerciseInfo(String exerciseName) async {
    try {
      List<Map<String, dynamic>> exercises = await _exerciseService.fetchExercises(exerciseName.toLowerCase());
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

  String _capitalizeFirstLetterOfEachWord(String input) {
    return input
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fetch Exercise',
          style: TextStyle(
            fontSize: 24.0,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Exercise Name',
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _fetchExerciseInfo(_controller.text);
              },
              child: Text(
                'Fetch Exercise Info',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 40),
            _exercises.isEmpty
                ? Text(
                    'No exercise data found',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = _exercises[index];
                        if (exercise.containsKey('error')) {
                          return Text(
                            exercise['error'] ?? 'Error',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          );
                        }
                        return ExerciseCard(exercise: exercise, userProvider: widget.userProvider);
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
  static const String apiKey = 'bd42feb2c0msh9d6def32c640a64p129898jsn5e10e71f428b';
  static const String host = 'exercisedb.p.rapidapi.com';

  Future<List<Map<String, dynamic>>> fetchExercises(String exerciseName) async {
    final encodedName = Uri.encodeComponent(exerciseName);
    final url = 'https://exercisedb.p.rapidapi.com/exercises/name/$encodedName?offset=0&limit=50';
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
          'name': (exerciseJson['name'] as String).toLowerCase(),
          'bodyPart': (exerciseJson['bodyPart'] as String).toLowerCase(),
          'gifUrl': (exerciseJson['gifUrl'] as String),
          'target': (exerciseJson['target'] as String).toLowerCase(),
          'instructions': exerciseJson['instructions'] != null
              ? List<String>.from(exerciseJson['instructions'].map((instr) => (instr as String).toLowerCase()))
              : [],
        };
      }).toList();
    }

    return exercises;
  }
}
class ExerciseCard extends StatelessWidget {
  final Map<String, dynamic> exercise;
  final UserProvider userProvider;

  ExerciseCard({required this.exercise, required this.userProvider});

  void _addToFavorites(BuildContext context) async {
    final user = userProvider.user!;
    if (!user.favorites!.contains(exercise['name'])) {
      user.favorites!.add(exercise['name']);

      UserModel updatedUser = UserModel(
        uid: user.uid,
        username: user.username,
        profileImageUrl: user.profileImageUrl,
        email: user.email,
        gender: user.gender,
        age: user.age,
        height: user.height,
        weight: user.weight,
        neck: user.neck,
        waist: user.waist,
        hips: user.hips,
        goal: user.goal,
        level: user.level,
        frequency: user.frequency,
        duration: user.duration,
        time: user.time,
        favorites: user.favorites,
      );

      await userProvider.updateUser(updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exercise added to favorites!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  String _capitalizeFirstLetterOfEachWord(String input) {
    return input
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).colorScheme.background,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exercise['name'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.star, color: Colors.red),
                  onPressed: () => _addToFavorites(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('Body Part: ${exercise['bodyPart'] ?? ''}', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            Text('Target: ${exercise['target'] ?? ''}', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            SizedBox(height: 10),
            exercise['gifUrl'] != null && exercise['gifUrl'].isNotEmpty
                ? Image.network(exercise['gifUrl'])
                : SizedBox.shrink(),
            SizedBox(height: 10),
            Text(
              'Instructions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            ...?exercise['instructions']?.map(
              (instruction) => Text(instruction, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
