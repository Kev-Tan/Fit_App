import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Parser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExerciseParserPage(),
    );
  }
}

class ExerciseParserPage extends StatefulWidget {
  @override
  _ExerciseParserPageState createState() => _ExerciseParserPageState();
}

class _ExerciseParserPageState extends State<ExerciseParserPage> {
  final String inputData = """
  [{'bodyPart': 'upper arms', 'equipment': 'band', 'gifUrl': 'https://v2.exercisedb.io/image/5iaVUg9cNfj4-F', 'id': '0975', 'name': 'band close-grip push-up', 'target': 'triceps', 'secondaryMuscles': ['chest', 'shoulders'], 'instructions': ['Place a band around your upper arms, just above the elbows.', 'Assume a push-up position with your hands directly under your shoulders and your body in a straight line from head to heels.', 'Bend your elbows and lower your chest towards the ground, keeping your elbows close to your sides.', 'Push through your palms to extend your arms and return to the starting position.', 'Repeat for the desired number of repetitions.']}]
  [{'bodyPart': 'upper legs', 'equipment': 'band', 'gifUrl': 'https://v2.exercisedb.io/image/S1G2zDMtPP8fzd', 'id': '0987', 'name': 'band one arm single leg split squat', 'target': 'quads', 'secondaryMuscles': ['glutes', 'hamstrings'], 'instructions': ['Stand with your feet hip-width apart and place a resistance band around your ankles.', 'Extend one leg forward and rest the top of your foot on a bench or step behind you.', 'Hold onto a support with one hand for balance.', 'Bend your standing leg and lower your body down into a squat position, keeping your knee in line with your toes.', 'Push through your heel to return to the starting position.', 'Repeat for the desired number of repetitions, then switch legs.']}]
  [{'bodyPart': 'waist', 'equipment': 'body weight', 'gifUrl': 'https://v2.exercisedb.io/image/dngZsxA9T48ROu', 'id': '2466', 'name': 'bridge - mountain climber (cross body)', 'target': 'abs', 'secondaryMuscles': ['glutes', 'quadriceps', 'hamstrings', 'shoulders', 'triceps'], 'instructions': ['Start in a high plank position with your hands directly under your shoulders and your body in a straight line.', 'Engage your core and lift your right foot off the ground, bringing your right knee towards your left elbow.', 'Return your right foot to the starting position and repeat the movement with your left foot towards your right elbow.', 'Continue alternating sides, moving at a controlled pace.', 'Keep your hips level and avoid lifting your hips too high or sagging them too low.', 'Maintain a steady breathing pattern throughout the exercise.', 'Repeat for the desired number of repetitions.']}]
  [{'bodyPart': 'waist', 'equipment': 'body weight', 'gifUrl': 'https://v2.exercisedb.io/image/vzzDKm4LWhASJn', 'id': '3544', 'name': 'bodyweight incline side plank', 'target': 'abs', 'secondaryMuscles': ['obliques', 'shoulders'], 'instructions': ['Start by lying on your side with your legs extended and stacked on top of each other.', 'Place your forearm on the ground directly below your shoulder, with your elbow bent at a 90-degree angle.', 'Engage your core and lift your hips off the ground, creating a straight line from your head to your feet.', 'Hold this position for the desired amount of time.', 'Lower your hips back down to the ground and repeat on the other side.']}]
  [{'bodyPart': 'cardio', 'equipment': 'body weight', 'gifUrl': 'https://v2.exercisedb.io/image/9KIExNYiRNsmyW', 'id': '1160', 'name': 'burpee', 'target': 'cardiovascular system', 'secondaryMuscles': ['quadriceps', 'hamstrings', 'calves', 'shoulders', 'chest'], 'instructions': ['Start in a standing position with your feet shoulder-width apart.', 'Lower your body into a squat position by bending your knees and placing your hands on the floor in front of you.', 'Kick your feet back into a push-up position.', 'Perform a push-up, keeping your body in a straight line.', 'Jump your feet back into the squat position.', 'Jump up explosively, reaching your arms overhead.', 'Land softly and immediately lower back into a squat position to begin the next repetition.']}]
  """;

  List<Map<String, dynamic>> _parsedExercises = [];

  void _parseExercises() {
    setState(() {
      _parsedExercises = parseExercises(inputData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Parser'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _parseExercises,
              child: Text('Show Exercises'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _parsedExercises.length,
              itemBuilder: (context, index) {
                final exercise = _parsedExercises[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(exercise['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Body Part: ${exercise['bodyPart']}"),
                        Text("Target: ${exercise['target']}"),
                        Text("Instructions: ${exercise['instructions'].join(", ")}"),
                      ],
                    ),
                    trailing: Image.network(exercise['gifUrl']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> parseExercises(String input) {
  List<Map<String, dynamic>> exercises = [];

  // Split the input into individual exercise blocks
  List<String> exerciseStrings = input.split("}");
  exerciseStrings = exerciseStrings.map((e) => e.replaceAll(RegExp(r'[\[\]]'), '').trim()).toList();

  for (String exerciseString in exerciseStrings) {
    if (exerciseString.isEmpty) continue;

    // Extract fields manually using regex
    final name = RegExp(r"'name': '([^']*)'").firstMatch(exerciseString)?.group(1) ?? '';
    final bodyPart = RegExp(r"'bodyPart': '([^']*)'").firstMatch(exerciseString)?.group(1) ?? '';
    final gifUrl = RegExp(r"'gifUrl': '([^']*)'").firstMatch(exerciseString)?.group(1) ?? '';
    final target = RegExp(r"'target': '([^']*)'").firstMatch(exerciseString)?.group(1) ?? '';
    final instructionsMatch = RegExp(r"'instructions': \[([^\]]*)\]").firstMatch(exerciseString);
    List<String> instructions = [];
    if (instructionsMatch != null) {
      // Extract the instructions string and convert it to a JSON array format
      String instructionsString = instructionsMatch.group(1)?.replaceAll("'", '"') ?? '';
      // Ensure it is properly wrapped in square brackets
      instructionsString = '[$instructionsString]';
      try {
        instructions = List<String>.from(json.decode(instructionsString));
      } catch (e) {
        print('Error parsing instructions: $e');
      }
    }

    exercises.add({
      'name': name,
      'bodyPart': bodyPart,
      'gifUrl': gifUrl,
      'target': target,
      'instructions': instructions,
    });
  }

  return exercises;
}
