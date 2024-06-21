import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:fit_app/models/user_provider.dart';

class WorkoutPage extends StatefulWidget {
  final UserProvider userProvider;
  const WorkoutPage({Key? key, required this.userProvider}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  bool _isLoading = false;
  String _workoutPlan = "";
  List<dynamic> exercisesData = [];
  TextEditingController bodyPartController = TextEditingController();
  TextEditingController limitController = TextEditingController();

  Future<void> _generateWorkoutPlan(UserModel user) async {
    setState(() {
      _isLoading = true;
      _workoutPlan = "";
    });

    const apiKey = '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';
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': 'gpt-4',
      'messages': [
        {
          'role': 'user',
          'content':
              "Please create a workout plan for a person with the following details: "
                  "Age: ${user.age}, Weight: ${user.weight}kg, Height: ${user.height}cm, Neck circumference: ${user.neck}cm. with these are the parameters :  The available body parts are back, cardio, chest, lower arms, lower legs, neck, shoulders, upper arms, upper legs, waist. The available targets are abductors, abs, adductors, biceps, calves, cardiovascular system, delts, forearms, glutes, hamstrings, lats, levator scapulae, pectorals, quads, serratus anterior, spine, traps, triceps, upper back. The available equipment are assisted, band, barbell, body weight, bosu ball, cable, dumbbell, elliptical machine, ez barbell, hammer, kettlebell, leverage machine, medicine ball, olympic barbell, resistance band, roller, rope, skierg machine, sled machine, smith machine, stability ball, stationary bike, stepmill machine, tire, trap bar, upper body ergometer, weighted, wheel roller., and when you gives the answer, please put it in a format like : [Day 1[Upper Body Strength Training[Bench Press, Target : Pectorals, Equipment : Dumbbell, 3 sets of 12 reps], Bicep Curls...]], because I want to use another AI to generate the gif"
        }
      ],
      'stream': true,
    });

    try {
      final request = http.Request('POST', url);
      request.headers.addAll(headers);
      request.body = body;

      final response = await request.send();

      response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
        (line) {
          if (line.startsWith('data: ')) {
            try {
              final jsonResponse = jsonDecode(line.substring(6));
              if (jsonResponse['choices'] != null &&
                  jsonResponse['choices'].isNotEmpty) {
                final content = jsonResponse['choices'][0]['delta']['content'];
                if (content != null) {
                  setState(() {
                    _workoutPlan += content;
                  });
                }
              }
            } catch (e) {
              print('Error parsing JSON: $e');
            }
          }
        },
        onDone: () {
          setState(() {
            _isLoading = false;
          });
        },
        onError: (error) {
          print('Error: $error');
          setState(() {
            _isLoading = false;
          });
        },
      );
    } catch (error) {
      print('Request failed: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void fetchData(String bodyPart, String limit) async {
    var headers = {
      'X-RapidAPI-Key': '6ae9d2f9cfmsha7480add98ae68bp1ab1aajsn7ccbd4d54b61',
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    };

    var uri = Uri.https('exercisedb.p.rapidapi.com',
        '/exercises/bodyPart/$bodyPart', {'limit': limit});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response and extract exercise data
      setState(() {
        exercisesData = json.decode(response.body);
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? user = widget.userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workout Options',
          style: TextStyle(
            fontSize: 24.0,
            color: Color(0xFF00008B),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Choose an option:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Text fields for entering body part and limit
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: bodyPartController,
                decoration: const InputDecoration(
                  labelText: 'Enter Body Part~~',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: limitController,
                decoration: const InputDecoration(
                  labelText: 'Enter Limit',
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Button to trigger data fetching
            ElevatedButton(
              onPressed: () {
                fetchData(bodyPartController.text, limitController.text);
              },
              child: const Text('Fetch Exercises'),
            ),
            const SizedBox(height: 10),
            // Button to generate workout plan for today
            ElevatedButton(
              onPressed: user != null
                  ? () {
                      _generateWorkoutPlan(user);
                    }
                  : null,
              child: const Text('Generate Workout for Today'),
            ),
            const SizedBox(height: 10),
            if (_isLoading) const CircularProgressIndicator(),
            // Display workout plan
            if (_workoutPlan.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _workoutPlan,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            // Display exercise details
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
    required this.number,
    required this.exerciseName,
    required this.bodyPart,
    required this.target,
    required this.equipment,
    required this.gifUrl,
    required this.instructions,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. Exercise Name: $exerciseName',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Body Part: $bodyPart'),
          Text('Target: $target'),
          Text('Equipment: $equipment'),
          Image.network(gifUrl),
          //Text(gifUrl),
          const SizedBox(height: 11),
          const Text(
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
    );
  }
}

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => UserProvider(),
//       child: MaterialApp(
//         home: WorkoutPage(),
//       ),
//     ),
//   );
// }
