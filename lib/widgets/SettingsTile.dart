import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData? icon;
  final ImageProvider? avatar;
  final String text;
  final String? subtext;

  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    this.icon,
    this.avatar,
    required this.text,
    this.subtext,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: avatar != null
            ? CircleAvatar(radius: 20, backgroundImage: avatar)
            : (icon != null ? Icon(icon, color: Colors.black) : null),
        title: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtext != null
            ? Text(subtext!, style: TextStyle(color: Colors.grey))
            : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
