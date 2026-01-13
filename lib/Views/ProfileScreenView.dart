import 'package:flutter/material.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset("images/setting_header_image.png"),

              Positioned(
                bottom: -100,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),

                    const SizedBox(height: 8),
                    const Text(
                      "PHOOLU",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "phoolu@gmail.com",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 100,),

          Expanded(
            child: ListView(
              children: [
                _buildSettingList("Personal Details", Icons.person_outline),
                _buildSettingList("Help & Support", Icons.question_mark),
                _buildSettingList("Privacy & Policy", Icons.security_outlined),
                _buildSettingList("Terms & Conditions", Icons.content_paste_search_outlined),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingList(String titleText, IconData iconName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Text(titleText, style: TextStyle(fontSize: 18),),
        leading: Container(padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(iconName)),
        trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
