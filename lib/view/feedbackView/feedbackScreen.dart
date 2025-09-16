import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/ChipsSection.dart';
import '../../widgets/Ratingstar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  bool isLoading = false;

  Future<void> submitFeedback(BuildContext context) async {
    if (rating == 0 &&
        likedOptions.isEmpty &&
        improvementOptions.isEmpty &&
        feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide some feedback")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? "anonymous";

      await FirebaseFirestore.instance.collection('feedbacks').add({
        'userId': uid,
        'rating': rating,
        'liked': likedOptions,
        'improvements': improvementOptions,
        'comments': feedbackController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for your feedback!")),
      );

      // Optionally clear the form
      setState(() {
        rating = 0;
        likedOptions.clear();
        improvementOptions.clear();
        feedbackController.clear();
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting feedback: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<String> likedList = [
      loc.easyToUse,
      loc.complete,
      loc.helpful,
      loc.convenient,
      loc.looksGood,
    ];

    final List<String> improveList = [
      loc.moreComponents,
      loc.complex,
      loc.notInteractive,
      loc.onlyEnglish,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.feedback,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.experienceFinished,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                loc.rateApp,
                style: const TextStyle(fontSize: 14, ),
              ),
              const SizedBox(height: 12),
              RatingStars(
                rating: rating,
                onRate: (value) => setState(() => rating = value),
              ),
              const SizedBox(height: 50),
              ChipsSection(
                title: loc.whatDidYouLike,
                options: likedList,
                selectedOptions: likedOptions,
                onSelected: (item, val) {
                  setState(() {
                    if (val) likedOptions.add(item);
                    else likedOptions.remove(item);
                  });
                },
              ),
              const SizedBox(height: 20),
              ChipsSection(
                title: loc.whatCouldBeImproved,
                options: improveList,
                selectedOptions: improvementOptions,
                onSelected: (item, val) {
                  setState(() {
                    if (val) improvementOptions.add(item);
                    else improvementOptions.remove(item);
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                loc.anythingElse,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: loc.tellUsEverything,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => submitFeedback(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6155F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          loc.submit,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
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
