import 'package:flutter/material.dart';

class SettingsFooterLinks extends StatelessWidget {
  const SettingsFooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final links = [
      {'icon': Icons.chat_bubble_outline, 'label': 'Contact us'},
      {'icon': Icons.star_border, 'label': 'Leave us a comment'},
      {'icon': Icons.tiktok, 'label': 'Check out our TikTok'},
      {'icon': Icons.camera_alt_outlined, 'label': 'Check out our Instagram'},
      {'icon': Icons.delete_outline, 'label': 'Delete account'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.grey),
        ...links.map((link) => ListTile(
              leading: Icon(link['icon'] as IconData, color: Colors.white),
              title: Text(link['label'] as String,
                  style: const TextStyle(color: Colors.white)),
              onTap: () {},
            )),
        const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Center(
            child: Text(
              "Version 1.0.0 🚀\nMade with ❤️ for students",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
