import 'package:flutter/material.dart';

class InvestmentsScreenView extends StatefulWidget {
  const InvestmentsScreenView({super.key});

  @override
  State<InvestmentsScreenView> createState() => _InvestmentsScreenViewState();
}

class _InvestmentsScreenViewState extends State<InvestmentsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){}, backgroundColor: Colors.green, child: Icon(Icons.add, color: Colors.white,),),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0, // Aspect ratio of each child
          ),
          children: [
            // List of widgets to display in the grid
            Card(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("FDR", style: TextStyle(fontSize: 20, color: Colors.white),),
                  Text("\$1200.00", style: TextStyle(fontSize: 20, color: Colors.white),),
                  Text("Last Update: 12/09/2025", style: TextStyle(fontSize: 14, color: Colors.white),),
                ],
              ),
            ),
            Card(
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("FDR", style: TextStyle(fontSize: 20, color: Colors.white),),
                  Text("\$1200.00", style: TextStyle(fontSize: 20, color: Colors.white),),
                  Text("Last Update: 12/09/2025", style: TextStyle(fontSize: 14, color: Colors.white),),
                ],
              ),
            ),
            Card(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("FDR", style: TextStyle(fontSize: 20, color: Colors.white),),
                  Text("\$1200.00", style: TextStyle(fontSize: 20, color: Colors.white),),
                  Text("Last Update: 12/09/2025", style: TextStyle(fontSize: 14, color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
