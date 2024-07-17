import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Bot',
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
  final List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({"text": _controller.text, "sender": "user"});
    });

    final response = await http.post(
      Uri.parse('https://api.coze.com/open_api/v2/chat'),
      headers: {
        'Authorization': 'Bearer pat_R6TKGWoG9UgP9IHz9OkuuSlkl4YwlWSVJRBI1Yh0kpy7DbGWyXABXLPZh88TqZkm',
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
      body: json.encode({
        "conversation_id": "123",
        "bot_id": "7392517553328816133",
        "user": "29032201862555",
        "query": _controller.text,
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final messages = data['messages'];

      for (var message in messages) {
        if (message['type'] == 'answer') {
          setState(() {
            _messages.add({"text": message['content'], "sender": "bot"});
          });
        }
      }
    } else {
      setState(() {
        _messages.add({"text": "Error: Unable to get response", "sender": "bot"});
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: message['sender'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: message['sender'] == 'user' ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
