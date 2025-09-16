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
    profileImage: null,
  );

  final ChatUser _bot = ChatUser(
    id: "2",
    firstName: "Bot",
    profileImage:
        null,
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat Bot",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 1,
      ),
      body: DashChat3(
        currentUser: _user,
        messages: _messages,
        onSend: _onSend,

        /// Bubble Style
        messageOptions: MessageOptions(
          showTime: true,
          currentUserContainerColor:
              isDark ? Colors.blueAccent[700]! : Colors.blue[400]!,
          containerColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
          currentUserTextColor: Colors.white,
        ),

        /// Date Separator
        messageListOptions: MessageListOptions(
          showDateSeparator: true,
          dateSeparatorBuilder: (date) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  DateFormat('EEEE, MMM d, yyyy').format(date),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
