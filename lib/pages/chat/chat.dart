import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:fit_app/models/user_provider.dart';

class ChatPage extends StatefulWidget {
  final UserProvider userProvider; // Add UserProvider parameter
  const ChatPage({Key? key, required this.userProvider}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  List<Map<String, String>> _messages = [];
  String _responseBuffer = "";

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    UserModel? user = widget.userProvider.user;
    if (user != null) {
      List<Map<String, String>> messages =
          await widget.userProvider.loadMessages(user.uid);
      setState(() {
        _messages = messages;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _messages.add({'role': 'user', 'content': _controller.text});
    });

    const apiKey = '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';
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': 'gpt-4',
      'messages': _messages,
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
                    _responseBuffer += content;
                  });
                }
              }
            } catch (e) {
              print('Error parsing JSON: $e');
            }
          }
        },
        onDone: () async {
          setState(() {
            _isLoading = false;
            if (_responseBuffer.isNotEmpty) {
              _messages.add({'role': 'assistant', 'content': _responseBuffer});
              _responseBuffer = "";
            }
          });

          // Save messages to Firestore after chat completes
          await _saveMessagesToFirestore();
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

    _controller.clear();
  }

  // Save messages to Firestore
  Future<void> _saveMessagesToFirestore() async {
    UserModel? user = widget.userProvider.user;
    if (user != null) {
      String recipientId = user.uid;
      for (final message in _messages) {
        await widget.userProvider
            .saveMessage(message['content']!, message['role']!, recipientId);
      }
    }
  }

  // Build chat message UI
  Widget _buildChatMessage(Map<String, String> message) {
    return ListTile(
      title: Text(
        message['content']!,
        style: TextStyle(
          color: message['role'] == 'user' ? Colors.black : Colors.blue,
        ),
        textAlign: message['role'] == 'user' ? TextAlign.right : TextAlign.left,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Ask me please!',
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xFF00008B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Hi, I am ActiveAI. How can I help you today?',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF00008B),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildChatMessage(message);
                    },
                  ),
                ),
                if (_isLoading) const CircularProgressIndicator(),
                const SizedBox(height: 24),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter your message',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
