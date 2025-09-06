import 'package:flutter/material.dart';
import '../../widgets/ChipsSection.dart';
import '../../widgets/Ratingstar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 0;
  List<String> likedOptions = [];
  List<String> improvementOptions = [];
  final TextEditingController feedbackController = TextEditingController();

  final List<String> likedList = [
    "Easy to use",
    "Complete",
    "Helpful",
    "Convenient",
    "Looks good",
  ];

  final List<String> improveList = [
    "Could have more components",
    "Complex",
    "Not interactive",
    "Only English",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Experience is finished.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "How would you rate the app?",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 12),
              RatingStars(
                rating: rating,
                onRate: (val) {
                  setState(() => rating = val);
                },
              ),

              SizedBox(height: 50),
              ChipsSection(
                title: "What did you like about it?",
                options: likedList,
                selectedOptions: likedOptions,
                onSelected: (item, val) {
                  setState(() {
                    if (val) {
                      likedOptions.add(item);
                    } else {
                      likedOptions.remove(item);
                    }
                  });
                },
              ),

              SizedBox(height: 20),

              ChipsSection(
                title: "What could be improved?",
                options: improveList,
                selectedOptions: improvementOptions,
                onSelected: (item, value) {
                  setState(() {
                    if (value) {
                      improvementOptions.add(item);
                    } else {
                      improvementOptions.remove(item);
                    }
                  });
                },
              ),

              SizedBox(height: 20),

              Text(
                "Anything else?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tell us everything.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6155F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
