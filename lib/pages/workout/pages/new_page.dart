import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:fit_app/models/user_provider.dart';
import 'dart:async';
import 'package:fit_app/models/user_provider.dart';

class ChatPage extends StatefulWidget {
  final UserProvider userProvider;

  const ChatPage({Key? key, required this.userProvider}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _parsedMessages = [];
  bool _showGenerateButton = true;
  bool _showDropdown = true; // Control visibility of the Rest Time dropdown
  int _selectedNumber = 1; // Variable to hold selected dropdown value

  List<Map<String, dynamic>> _parseResponse(String input) {
    List<Map<String, dynamic>> exercises = [];

    List<String> exerciseStrings = input.split("}");
    exerciseStrings = exerciseStrings.map((e) => e.replaceAll(RegExp(r'[\[\]]'), '').trim()).toList();

    for (String exerciseString in exerciseStrings) {
      if (exerciseString.isEmpty) continue;

      final name = RegExp(r'"name": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
      final bodyPart = RegExp(r'"bodyPart": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
      final gifUrl = RegExp(r'"gifUrl": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
      final target = RegExp(r'"target": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
      // Find the index of the word "instructions"
  int startIndex = exerciseString.indexOf("instructions");
   String result='';
   List<String> instructions = [];
  if (startIndex != -1) {
    // Move the start index to the end of the word "instructions"
    startIndex += "instructions".length;

    // Find the index of the closing
    int endIndex = exerciseString.indexOf("name", startIndex);
    if (endIndex != -1) {
      // Extract the substring between startIndex and endIndex
       result = exerciseString.substring(startIndex, endIndex).trim();
       result = result.replaceAll('"', '')
                     .replaceAll(',', '')
                     .replaceAll('[', '')
                     .replaceAll(']', '')
                     .replaceAll('\'', '')
                     .replaceAll(':', '');
      print(result); // Output: "this is the part we want"
      instructions.add(result);
    } else {
      print('Closing bracket not found');
    }
  } else {
    print('Word "instructions" not found');
  }
      // final instructo = RegExp(r'"instructions": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
      
      // RegExp instructionsRegExp = RegExp(r'"instructions":\s*\[([^\]]*?)\]', multiLine: true);
RegExp itemsRegExp = RegExp(r'"([^"]+)"');

// Match? instructionsMatch = instructionsRegExp.firstMatch(exerciseString);


// if (instructionsMatch != null) {
//   String instructionsBlock = instructionsMatch.group(1) ?? '';

  // Find the position where ".']}] appears
 // int endIndex = instructionsBlock.indexOf('".\']}]');

  // Adjust endIndex to include the full stopping characters (".']}]")
  // if (endIndex != -1) {
  //   endIndex += 6; // This adjusts to include the length of ".']}]
  // } else {
  //   endIndex = instructionsBlock.length; // If not found, take the whole block
  // }

  // Extract substring up to endIndex
 // String trimmedInstructionsBlock = instructionsBlock.substring(0, endIndex);

  //Iterable<Match> itemsMatches = itemsRegExp.allMatches(trimmedInstructionsBlock);

  // for (Match match in itemsMatches) {
  //   String instruction = match.group(1)?.trim() ?? '';
  //  // instructions.add(result);
  // }
//}
print("NINCOMPOOP-i");
print(instructions);

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

  Future<void> _sendMessage(String message, String userId) async {
    final url = 'https://e217-140-114-87-235.ngrok-free.app/chat';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message, 'user_id': userId}),
    );

    if (response.statusCode == 200) {
      setState(() {
        print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
        widget.userProvider.resetExercises();
        print('resetting');
        _parsedMessages.clear();
        _parsedMessages = _parseResponse(response.body);
        print("NINCOMPOOP");
        print(response.body);
        _showGenerateButton = false;
        _showDropdown = true; // Show the Rest Time dropdown after generating exercises
        
        widget.userProvider.updateExercises(_parsedMessages);

      // Save to Firebase
        widget. userProvider.saveExercisesToFirebase(_parsedMessages);      });
    } else {
      setState(() {
        _parsedMessages.clear();
        _parsedMessages.add({'error': "Couldn't get a response from AI."});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = widget.userProvider.user;
    List<Map<String, dynamic>> exercises = widget.userProvider.exercises;

    String defaultMessage =
        'Generate workout for today in JSON format, and please make sure none of the excercises are the same and that they are varied, where each exercise includes the name, the reps and the duration, please give me a maximum of only FIVE as I will NOT accept more than 5 exercises and please say nothing but directly the json format based on the file, make it "name". '
        'Please create a workout plan with 5 exercises only for a person with the following details: '
        'Age: ${user?.age}, Weight: ${user?.weight ?? 'N/A'}kg, Height: ${user?.height ?? 'N/A'}cm, Neck circumference: ${user?.neck ?? 'N/A'}cm, '
        'Waist circumference: ${user?.waist ?? 'N/A'}cm, Hip circumference: ${user?.hips ?? 'N/A'}cm, Gender: ${user?.gender ?? 'N/A'}, '
        'Goal: ${user?.goal ?? 'N/A'}, Level: ${user?.level ?? 'N/A'}, Frequency: ${user?.frequency ?? 'N/A'}, '
        'Duration: ${user?.duration ?? 'N/A'}}.';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Workout for Today',
          style: TextStyle(
            fontSize: 24.0,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_showGenerateButton)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  _sendMessage(defaultMessage, '${user?.uid ?? 'N/A'}'); // Pass user id
                },
                child: Text(
                  'Generate Workout',
                  style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                  ),
                )
              ),
            ),
          
          Expanded(
            child: exercises.isNotEmpty
                ? ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
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
                          trailing: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(exercise['gifUrl']),
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: 
                Text(
                  'No exercises',
                  style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  ))),
          ),
          if (_showDropdown)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rest Time', // Explanation of the dropdown button
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      )
                  ),
                  DropdownButton<int>(
                    value: _selectedNumber,
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedNumber = newValue!;
                      });
                    },
                    items: List.generate(11, (index) => DropdownMenuItem<int>(
                      value: index+1,
                      child: Text((index+1).toString()),
                    )),
                  ),
                ],
              ),
            ),
          if (exercises.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutPage(exercises:exercises, duration: _selectedNumber),
                    ),
                  );
                },
                child: Text(
                  'Start Workout',
                  style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                  )
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                  ),
                )
              ),
            ),
        ],
      ),
    );
  }
}

class WorkoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  final int duration;

  const WorkoutPage({Key? key, required this.exercises, required this.duration}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  int _currentPageIndex = 0;
  bool _showTimer = false;
  Timer? _timer;
  int _timeRemaining = 0;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.duration * 60; // Initialize time based on selected duration
  }

  void _startTimer() {
    _cancelTimer();
    setState(() {
      _showTimer = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _moveToNextExercise();
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _moveToNextExercise() {
    _cancelTimer();
    setState(() {
      _showTimer = false;
      _currentPageIndex = (_currentPageIndex + 1) % widget.exercises.length;
      _timeRemaining = widget.duration * 60; // Reset time for next exercise
    });
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final exercise = widget.exercises[_currentPageIndex];
  int lastIdx = widget.exercises.length - 1;
  final double progress = (((widget.duration * 60.0) - _timeRemaining) / (widget.duration * 60.0));

  return Scaffold(
    appBar: AppBar(
      title: Text('Workout',
      style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            )
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    ),
    body: _showTimer
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rest for',
                  style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            )
                ),
                SizedBox(height: 20.0),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 10.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 212, 199, 199)),
                      ),
                    ),
                    Text(
                      '$_timeRemaining s',
                      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _moveToNextExercise,
                  child: Text(lastIdx == _currentPageIndex ? 'Finish' : 'Done',
                      style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold,
                )),
                style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  exercise['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Body Part: ${exercise['bodyPart']}"),
                    Text("Target: ${exercise['target']}"),
                    Text("Instructions: ${exercise['instructions'].join(", ")}"),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(exercise['gifUrl']),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPageIndex == lastIdx) {
                        // Perform actions to exit the page or finish the workout
                        // For example:
                        Navigator.pop(context); // Pop current page
                        // You might also want to reset or finalize your workout session
                      } else {
                        _startTimer();
                      }
                    },
                    child: Text(lastIdx == _currentPageIndex ? 'Finish' : 'Next',
                    style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).colorScheme.background,
              fontWeight: FontWeight.bold,
            )),
            style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  ),
                ),
              ),
            ],
          ),
  );
}
}
