import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:fit_app/models/user_provider.dart';

class ChatPage extends StatefulWidget {
  final UserProvider userProvider;
  const ChatPage({Key? key, required this.userProvider}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _parsedMessages = [];

  // Helper function to manually parse the response string
  List<Map<String, dynamic>> _parseResponse(String input) {
  List<Map<String, dynamic>> exercises = [];

  // Split the input into individual exercise blocks
  List<String> exerciseStrings = input.split("}");
  exerciseStrings = exerciseStrings.map((e) => e.replaceAll(RegExp(r'[\[\]]'), '').trim()).toList();

  for (String exerciseString in exerciseStrings) {
    print(exerciseString);
    if (exerciseString.isEmpty) continue;

    // Extract fields manually using regex
    final name = RegExp(r'"name": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
    final bodyPart = RegExp(r'"bodyPart": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
    final gifUrl = RegExp(r'"gifUrl": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
    final target = RegExp(r'"target": "([^"]*)"').firstMatch(exerciseString)?.group(1) ?? '';
    final instructionsMatch = RegExp(r'"instructions":\s*([^,]*?)(?=\s*"\w+":|\s*$)', multiLine: true).firstMatch(exerciseString);
    List<String> instructions = [];
    if (instructionsMatch != null) {
      // Extract the instructions block and split by lines
      String instructionsBlock = instructionsMatch.group(1)?.trim() ?? '';
      instructions = instructionsBlock.split(RegExp(r',\s*"')).map((s) => s.trim().replaceAll(RegExp(r'^"|"$'), '')).toList();
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


  Future<void> _sendMessage(String message, String userId) async {
    final url = 'http://127.0.0.1:5000/chat'; // Replace with your server URL
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message, 'user_id': userId}),
    );

    print(userId);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        _parsedMessages.clear(); // Clear previous messages
        _parsedMessages.addAll(_parseResponse(response.body));
      });
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

    String defaultMessage =
        'Generate back workout for today in JSON format, where each exercise includes the name, the reps and the duration, please say nothing but directly the json format based on the file, make it "name". '
        'Please create a workout plan for a person with the following details: '
        'Age: ${user?.age}, Weight: ${user?.weight ?? 'N/A'}kg, Height: ${user?.height ?? 'N/A'}cm, Neck circumference: ${user?.neck ?? 'N/A'}cm, '
        'Waist circumference: ${user?.waist ?? 'N/A'}cm, Hip circumference: ${user?.hips ?? 'N/A'}cm, Gender: ${user?.gender ?? 'N/A'}, '
        'Goal: ${user?.goal ?? 'N/A'}, Level: ${user?.level ?? 'N/A'}, Frequency: ${user?.frequency ?? 'N/A'}, '
        'Duration: ${user?.duration ?? 'N/A'}, Preferred Time: ${user?.time ?? 'N/A'}.';

    print('${user?.age}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with AI'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _sendMessage(defaultMessage, '${user?.uid ?? 'N/A'}'); // Pass user id
              },
              child: Text('Generate'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _parsedMessages.length,
              itemBuilder: (context, index) {
                final exercise = _parsedMessages[index];
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
