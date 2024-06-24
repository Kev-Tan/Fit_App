import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_app/models/user_provider.dart';

class ChatPage extends StatefulWidget {
  final UserProvider userProvider;
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

    const apiKey = '';
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

  Widget _buildChatMessage(Map<String, String> message) {
    bool isUser = message['role'] == 'user';
    return Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isUser
                ? Theme.of(context).colorScheme.primary
                : Color.fromRGBO(200, 200, 200, 1),
            borderRadius: isUser
                ? BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0),
                  ),
          ),
          child: Text(
            message['content']!,
            style: TextStyle(
              color: isUser
                  ? Theme.of(context).colorScheme.background
                  : Color.fromRGBO(8, 31, 92, 1),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat with me',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hi, I am _____. How can I help you today?',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatMessage(message);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Type your message here',
                    labelStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
                const SizedBox(height: 8),
                // ElevatedButton(
                //   onPressed: _sendMessage,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blue,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 24.0, vertical: 12.0),
                //   ),
                //   child: const Text('Send'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
