import 'package:flutter/material.dart';

class TransactionsPartView extends StatelessWidget {
  const TransactionsPartView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transactions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Figma", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            subtitle: Text("02/03/2025", style: TextStyle(color: Colors.grey),),
            leading: Icon(Icons.book_sharp),
            trailing: Text("\$42.40", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          ListTile(
            title: Text("Figma", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            subtitle: Text("02/03/2025", style: TextStyle(color: Colors.grey),),
            leading: Icon(Icons.book_sharp),
            trailing: Text("\$42.40", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          ListTile(
            title: Text("Figma", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            subtitle: Text("02/03/2025", style: TextStyle(color: Colors.grey),),
            leading: Icon(Icons.book_sharp),
            trailing: Text("\$42.40", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}