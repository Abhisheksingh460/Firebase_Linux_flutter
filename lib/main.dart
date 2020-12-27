import 'package:firebase_app/terminal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter redhat',
    theme: ThemeData(
        primarySwatch: Colors.blue,
        cursorColor: Colors.black,
        backgroundColor: Colors.white),
    initialRoute: '/',
    routes: {
      '/': (context) => MyHomePage(),
      '/Signup': (context) => SignUp(),
      '/Terminal': (context) => MyTerminal(),
    },
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var authc = FirebaseAuth.instance;
var email;
var password;
var sspin = false;

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      onChanged: (value) {
        email = value;
      },
      style: style,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      onChanged: (value) {
        password = value;
      },
      style: style,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final forgot =
        Text("forgot password ? ", style: TextStyle(color: Colors.blueAccent));

    final appname = Text("RedHat",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ));
    final text = Text("Welcome Back",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ));
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          setState(() {
            sspin = true;
          });
          try {
            var outt = await authc.signInWithEmailAndPassword(
                email: email, password: password);
            print(outt);

            if (outt != null) {
              Navigator.pushNamed(context, '/Terminal');
              sspin = false;
            }
          } catch (e) {
            print(e);
          }
        },
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return ModalProgressHUD(
        inAsyncCall: sspin,
        child: Scaffold(
            body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/red1.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    appname,
                    SizedBox(
                      height: 15.0,
                    ),
                    text,
                    SizedBox(height: 30.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 20.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: forgot,
                          onPressed: () {
                            print("pressed on forgot passwd");
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New to RedHat ? "),
                        FlatButton(
                          child: Text(
                            "Join now",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          onPressed: () {
                            print("pressed on join");
                            Navigator.pushNamed(context, '/Signup');
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
