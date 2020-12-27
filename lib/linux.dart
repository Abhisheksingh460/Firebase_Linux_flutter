import 'package:flutter/material.dart';

class Linux extends StatefulWidget {
  @override
  _LinuxState createState() => _LinuxState();
}

class _LinuxState extends State<Linux> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Linux Terminal"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Root@LocalHost]#",
                style: TextStyle(color: Colors.white),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                alignment: Alignment.topCenter,
                color: Colors.blueAccent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Text(
                  "Output:- ",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
