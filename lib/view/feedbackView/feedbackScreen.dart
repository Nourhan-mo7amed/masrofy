import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // ✅ lists now use localized strings
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
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              RatingStars(
                rating: rating,
                onRate: (value) {
                  setState(() => rating = value);
                },
              ),

              const SizedBox(height: 50),
              ChipsSection(
                title: loc.whatDidYouLike,
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

              const SizedBox(height: 20),

              ChipsSection(
                title: loc.whatCouldBeImproved,
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

              const SizedBox(height: 20),

              Text(
                loc.anythingElse,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
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
                  onPressed: () {
                    // TODO: Handle submit action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6155F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
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
