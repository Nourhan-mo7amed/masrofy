import 'package:dash_chat_3/dash_chat_3.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();

  static bool isCompleted = false;
  static List<ChatMessage> answers = [];
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<ChatMessage> _messages = [];

  /// تعريف اليوزر والبوت
  final ChatUser _user = ChatUser(
    id: "1",
    firstName: "You",
    profileImage: "https://i.pravatar.cc/150?img=3", // صورة افتراضية لليوزر
  );

  final ChatUser _bot = ChatUser(
    id: "2",
    firstName: "Bot",
    profileImage:
        "https://cdn-icons-png.flaticon.com/512/4712/4712027.png", // أيقونة روبوت
  );

  final List<String> _questions = [
    "What's your average monthly spending?",
    "What is your biggest expense?",
    "Do you have any financial goals?",
  ];

  int _currentQuestion = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
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
      Future.delayed(const Duration(milliseconds: 500), () {
        _sendBotMessage(_questions[_currentQuestion]);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        _sendBotMessage("You have answered all questions!");
      });

      Future.delayed(const Duration(seconds: 1), () {
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
        title: const Text(
          "Chat Bot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: DashChat3(
        currentUser: _user,
        messages: _messages,
        onSend: _onSend,

        /// Bubble Style
        messageOptions: MessageOptions(
          showTime: true,
          currentUserContainerColor: Colors.blue[400]!,
          containerColor: Colors.grey[300]!,
          textColor: Colors.black,
          currentUserTextColor: Colors.white,
        ),

        /// Date Separator
        messageListOptions: MessageListOptions(
          showDateSeparator: true,
          dateSeparatorBuilder: (date) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  DateFormat('EEEE, MMM d, yyyy').format(date),
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
