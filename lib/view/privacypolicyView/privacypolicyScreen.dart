import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:masrofy/l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.privacyPolicyTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.privacyIntro,
                style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                loc.whatWeCollect,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                loc.whatWeCollectDetails,
                style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                loc.howWeUseData,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                loc.howWeUseDataDetails,
                style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                loc.storageAndSecurity,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                loc.storageAndSecurityDetails,
                style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                loc.dataSharing,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                loc.dataSharingDetails,
                style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
