import 'package:flutter/material.dart';
import 'package:todo/Screens/contants/loading.dart';
import 'package:todo/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent[400],
        elevation: 0.0,
        title: Text("Register",
          style: GoogleFonts.roboto(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,size: 25),
            label: Text('Sign In',
            style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
            onPressed: (){
              Navigator.popAndPushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  style: TextStyle(
                  fontSize: 20.0, color: Colors.cyanAccent[100]),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(()=> password= val);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0))),
                          fillColor: Colors.black45,
                          filled: true,
                          hintText: 'E-mail',
                          hintStyle: GoogleFonts.comfortaa(
                          fontSize: 15.0,
                          color: Colors.cyanAccent[100],
                         letterSpacing: 4.0
                         ),
              )
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 20.0, color: Colors.cyanAccent[100]),
                  onChanged: (val) {
                      setState(() => password = val);
                                  },
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:BorderRadius.all(Radius.circular(20.0))),
                  fillColor: Colors.black45,
                  filled: true,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.comfortaa(
                      fontSize: 15.0,
                      color: Colors.cyanAccent[100],
                      letterSpacing: 4.0),
              )),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.cyanAccent[400],
                child: Text(
                  'Register',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                  )
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}