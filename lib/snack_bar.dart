import 'package:flutter/material.dart';

class SnackBarDemo extends StatefulWidget {
  const SnackBarDemo({super.key});

  @override
  State<SnackBarDemo> createState() => _SnackBarDemoState();
}

class _SnackBarDemoState extends State<SnackBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SnackBar Demo"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    //scaffoldmeassenger is a function of scaffold...........................
                    const SnackBar(
                      content: Column(
                        children: [
                          Text("Error"),
                          Text("User Is not Found "),
                        ],
                      ),
                      margin: EdgeInsets.all(10),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.teal,
                    ),
                  );
                },
                color: Colors.teal,
                minWidth: double.infinity,
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
