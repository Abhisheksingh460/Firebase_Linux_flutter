import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(SignUp());

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

var password;
var email;
var authc = FirebaseAuth.instance;

class _SignUpState extends State<SignUp> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      style: style,
      onChanged: (value) {
        email = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      onChanged: (value) {
        password = value;
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final appname = Text("RedHat",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ));
    final text = Text("Join RedHat now ",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ));
    // ignore: non_constant_identifier_names
    final SignUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            var user = await authc.createUserWithEmailAndPassword(
                email: email, password: password);

            print(password);
            print(email);
            print(user);

            if (user.additionalUserInfo.isNewUser == true) {
              Navigator.pushNamed(context, '/Terminal');
            }
          } catch (e) {
            print(e);
          }
        },
        child: Text("Agree & join",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // ignore: non_constant_identifier_names
    final GoogleButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/google.jpg",
                height: 40,
              ),
              Text("Join with Google",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ));
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                appname,
                SizedBox(
                  height: 20.0,
                ),
                text,
                SizedBox(height: 40.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 20.0,
                ),
                Text("By clicking Agree & join , you agree to the RedHat"),
                Text(
                  "User Agreement,Privacy Policy,",
                  style: TextStyle(color: Colors.blue),
                ),
                Text("and "),
                Text(
                  "Cookie Policy.",
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SignUpButton,
                SizedBox(
                  height: 15.0,
                ),
                GoogleButon,
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already on RedHat ? "),
                    FlatButton(
                      child: Text(
                        "sign in",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onPressed: () {
                        print("pressed on sign in ");
                        Navigator.pop(context, '/');
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
