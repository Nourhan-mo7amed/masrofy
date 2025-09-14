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
        "details": '''
Phone : +1 555 123 4567
Email : support@masrofy.com
Working Hours : 9:00 AM – 6:00 PM
''',
      },
      {
        "icon": Icon(Icons.language, color: Color(0xFF6C63FF)),
        "title": "Website",
        "details": '''
Visit us : www.masrofy.com
Contact Form : www.masrofy.com/contact
''',
      },
      {
        "icon": FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF6C63FF)),
        "title": "Whatsapp",
        "details": '''
Chat with us : +1 555 987 6543
Available : 10:00 AM – 8:00 PM 
''',
      },
      {
        "icon": FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF6C63FF)),
        "title": "Facebook",
        "details": '''
Page : facebook.com/masrofyapp
Messenger : m.me/masrofyapp
''',
      },
      {
        "icon": FaIcon(FontAwesomeIcons.instagram, color: Color(0xFF6C63FF)),
        "title": "Instagram",
        "details": '''
Follow us : instagram.com/masrofyapp
DM us for support
''',
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
