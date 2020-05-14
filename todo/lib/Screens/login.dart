import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/services/auth.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("Sign In",
          style: GoogleFonts.roboto(
            color: Colors.cyanAccent[100],
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          
        ),
        body: Center(child: RaisedButton(
          child: Text("Sign In anon"),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result== null){
              print(result);
            }
            else{
              print('Result');
              print(result.uid);
            }
          },
        ),),
    );
  }
}