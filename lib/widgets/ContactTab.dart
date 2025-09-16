import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';

class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final contacts = [
      {
        "icon": Icon(Icons.headset_mic, color: Color(0xFF6C63FF)),
        "title": loc.contactCustomerService,
        "details": loc.contactCustomerServiceDetails,
      },
      {
        "icon": Icon(Icons.language, color: Color(0xFF6C63FF)),
        "title": loc.contactWebsite,
        "details": loc.contactWebsiteDetails,
      },
      {
        "icon": Icon(Icons.phone, color: Color(0xFF6C63FF)),
        "title": loc.contactWhatsapp,
        "details": loc.contactWhatsappDetails,
      },
      {
        "icon": Icon(Icons.facebook, color: Color(0xFF6C63FF)),
        "title": loc.contactFacebook,
        "details": loc.contactFacebookDetails,
      },
      {
        "icon": Icon(Icons.camera_alt_rounded, color: Color(0xFF6C63FF)),
        "title": loc.contactInstagram,
        "details": loc.contactInstagramDetails,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ExpansionTile(
              leading: contacts[index]["icon"] as Widget,
              title: Text(
                contacts[index]["title"] as String,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF6155F5),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    contacts[index]["details"] as String,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
