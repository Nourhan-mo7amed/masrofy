import 'package:flutter/material.dart';

class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      child: SwitchListTile(
        secondary: Icon(icon),
        title: Text(text),
        value: value,
        inactiveThumbColor: Colors.white,
        activeTrackColor: Color(0xFF6155F5),
        inactiveTrackColor: Colors.grey,
        onChanged: onChanged,
      ),
    );
  }
}
