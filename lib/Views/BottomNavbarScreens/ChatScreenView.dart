import 'package:flutter/material.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final _personSearchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final myData = [
    PersonListData(
        name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 03),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(
        name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 01),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(
        name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 05),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(
        name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 08),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
    PersonListData(name: "Anujit Datta", lastMgs: "Hi, Everyone", unSeenMgs: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _personSearchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search here...",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.purple.shade50,
                  // Default border (applies to all states if others are null)
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // No line
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView(
                  children: myData.map((value) {
                    return ListTile(
                        leading: CircleAvatar(child: Icon(Icons
                            .account_circle),),
                        title: Text(value.name),
                        subtitle: Text(value.lastMgs),
                        trailing: value.unSeenMgs > 0 ? CircleAvatar(radius: 12,
                          backgroundColor: Colors.purple, child: Text(
                          "${value.unSeenMgs}",
                          style: TextStyle(color: Colors.white),),) : null
                    );
                  }).toList()
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class PersonListData {
  final String name;
  final String lastMgs;
  final int unSeenMgs;

  PersonListData({
    required this.name,
    required this.lastMgs,
    required this.unSeenMgs,
  });
}
