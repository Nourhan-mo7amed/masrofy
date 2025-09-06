import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {
        "icon": Icon(Icons.headset_mic, color: Color(0xFF6C63FF)),
        "title": "Customer Service",
        "details": "",
      },
      {
        "icon": Icon(Icons.language, color: Color(0xFF6C63FF)),
        "title": "Website",
        "details": "",
      },
      {
        "icon": FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF6C63FF)),
        "title": "Whatsapp",
        "details": "",
      },
      {
        "icon": FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF6C63FF)),
        "title": "Facebook",
        "details": "",
      },
      {
        "icon": FaIcon(FontAwesomeIcons.instagram, color: Color(0xFF6C63FF)),
        "title": "Instagram",
        "details": "",
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
                    style: TextStyle(color: Colors.grey),
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
