import 'package:flutter/material.dart';

import '../utilities/helper_function.dart';

class SettingScreenView extends StatefulWidget {
  const SettingScreenView({super.key});

  @override
  State<SettingScreenView> createState() => _SettingScreenViewState();
}

class _SettingScreenViewState extends State<SettingScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        animateColor: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Setting"),
                Text(
                  "Manage your account preferences",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: "Profile Settings",
              icon: Icons.person_outline,
              children: [
                _buildItem(
                  title: "Display Name",
                  subtitle: "Demo User",
                  actionText: "Edit",
                ),
                _buildDivider(),
                _buildItem(
                  title: "Email Address",
                  subtitle: "a@gmail.com",
                  actionText: "Edit",
                ),
                _buildDivider(),
                _buildItem(
                  title: "Password",
                  subtitle: "******",
                  actionText: "Edit",
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: "Preferences",
              icon: Icons.settings_outlined,
              children: [
                _buildItem(
                  title: "Currency",
                  subtitle: "USD (\$)",
                  actionText: "Change",
                ),
                _buildDivider(),
                _buildItem(
                  title: "Theme",
                  subtitle: "System Default",
                  actionText: "Change",
                ),
                _buildDivider(),
                _buildItem(
                  title: "Language",
                  subtitle: "English (US)",
                  actionText: "Change",
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: "Notifications",
              icon: Icons.notifications_outlined,
              children: [
                _buildItem(
                  title: "Daily Reminder",
                  subtitle: "9:00 AM",
                  actionText: "Configure",
                ),
                _buildDivider(),
                _buildItem(
                  title: "Budget Alerts",
                  subtitle: "Enabled",
                  actionText: "Configure",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Section Card
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  // 🔹 Row Item
  Widget _buildItem({
    required String title,
    required String subtitle,
    required String actionText,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(subtitle),
      trailing: TextButton(onPressed: (){
        showTextInputDialog(context, "Edit", "Enter you text", "Cancel", "Save", Colors.red, Colors.green);
      }, child: Text(actionText, style: TextStyle(color: Colors.green),)),
      onTap: () {
        // handle action
      },
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey.shade300,
      indent: 16,
      endIndent: 16,
    );
  }
}
