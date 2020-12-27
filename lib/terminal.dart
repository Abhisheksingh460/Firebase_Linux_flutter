import 'package:firebase_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyTerminal extends StatefulWidget {
  @override
  Mystate createState() => Mystate();
}

class Mystate extends State<MyTerminal> {
  var msgcontroller = TextEditingController();
  var cmd;
  var state;

  data(cmd) async {
    var fsconnect = FirebaseFirestore.instance;
    var authc = FirebaseAuth.instance;
    var signInUser = authc.currentUser.email;

    var url = "http://192.168.43.48/cgi-bin/linux.py?x=${cmd}";
    var response = await http.get(url);

    setState(() {
      state = response.body;
    });
    await fsconnect.collection('student').add({
      "User": signInUser,
      '$cmd': '$state',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Terminal',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center),
          leading: Image.asset('assets/red1.png'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await authc.signOut();
                  Navigator.pushNamed(context, '/');
                })
          ],
          backgroundColor: Color(0xff01A0C7),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Card(
                      color: Colors.black,
                      child: TextField(
                        controller: msgcontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: '  Enter Your Command',
                            hintStyle: TextStyle(color: Colors.red),
                            fillColor: Colors.white,
                            prefixText: '[root@localhost ~]# ',
                            prefixStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                            focusColor: Colors.blue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45))),
                        onChanged: (value) {
                          cmd = value;
                        },
                        autocorrect: true,
                        showCursor: true,
                      ),
                    ),
                  )),
                  Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                      child: Material(
                        color: Color(0xff01A0C7),
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: MaterialButton(
                          splashColor: Colors.blue,
                          minWidth: 200,
                          height: 40,
                          onPressed: () {
                            data(cmd);
                            msgcontroller.clear();
                          },
                          child: Text('Run Command'),
                          textColor: Colors.black,
                        ),
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.66,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey),
                    child: Card(
                      color: Colors.black,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            state ?? " Output Screen ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
