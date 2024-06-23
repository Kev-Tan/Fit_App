import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat with AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  String userId = "4"; // Unique identifier for the user

  String defaultMessage =
      'Generate  workout for today in JSON format, where each exercise includes the name, the reps and the duration, please say nothing but directly the json format based on the file, make it like for example "name" : "push up"';

  Future<void> _sendMessage(String message) async {
    final url = 'http://127.0.0.1:5000/chat'; // Replace with your server URL
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message, 'user_id': userId}),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      print('hello');
      print(response.body);
      setState(() {
        _messages.clear(); // Clear previous messages
        _messages.add("Exercises Datass:");
        _messages.add(response.body);
      });
    } else {
      setState(() {
        _messages.add("Error: Couldn't get a response from AI.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _sendMessage(defaultMessage);
                    },
                    child: Text('Send Default Message'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
