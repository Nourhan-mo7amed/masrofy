import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:intl/intl.dart';
import '../../view/reportView/reportScreen.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();

  static bool isCompleted = false;
  static List<ChatMessage> answers = [];
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<ChatMessage> _messages = [];
  final ChatUser _user = ChatUser(id: "1", firstName: "You");
  final ChatUser _bot = ChatUser(id: "2", firstName: "Bot");

  final List<String> _questions = [
    "What's your average monthly spending?",
    "What is your biggest expense?",
    "Do you have any financial goals?",
  ];

  int _currentQuestion = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _sendBotMessage(_questions[_currentQuestion]);
    });
  }

  void _sendBotMessage(String text) {
    final botMessage = ChatMessage(
      text: text,
      user: _bot,
      createdAt: DateTime.now(),
    );
    setState(() {
      _messages.insert(0, botMessage);
    });
  }

  void _onSend(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });

    if (_currentQuestion < _questions.length - 1) {
      _currentQuestion++;
      Future.delayed(Duration(milliseconds: 500), () {
        _sendBotMessage(_questions[_currentQuestion]);
      });
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        _sendBotMessage("You have answered all questions!");
      });

      Future.delayed(Duration(seconds: 1), () {
        ChatBotScreen.isCompleted = true;
        ChatBotScreen.answers = _messages;
        Navigator.pushNamed(context, '/report', arguments: _messages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Bot", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: DashChat(
        currentUser: _user,
        messages: _messages,
        onSend: _onSend,
        messageOptions: MessageOptions(
          showTime: true,
          timeFormat: DateFormat('hh:mm a'),
        ),
        messageListOptions: MessageListOptions(
          showDateSeparator: true,
          dateSeparatorBuilder: (date) {
            return Center(
              child: Text(
                DateFormat('EEEE, MMM d, yyyy').format(date),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
