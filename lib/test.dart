import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Send Data to Flask', home: SendDataScreen());
  }
}

class SendDataScreen extends StatefulWidget {
  const SendDataScreen({super.key});

  @override
  _SendDataScreenState createState() => _SendDataScreenState();
}

class _SendDataScreenState extends State<SendDataScreen> {
  final TextEditingController _controller = TextEditingController();
  String responseMessage = '';

  Future<void> sendData(String inputText) async {
    final url = 'http://127.0.0.1:5000/send-data';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({'message': inputText}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        responseMessage = 'Server response: ${data['status']}';
      });
    } else {
      setState(() {
        responseMessage = 'Failed to send data.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Data to Flask')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendData(_controller.text),
              child: Text('Send'),
            ),
            SizedBox(height: 20),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}
