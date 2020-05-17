import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/services/auth.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xff202020),
                  ),
                  child: Column(
                    children: [
                      Container(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
                Text(
                  'Sign In',
                  style: GoogleFonts.galada(
                      color: Colors.white,
                      fontSize: 40.0,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                TextFormField(
                  decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(20.0))),
                            fillColor: Colors.black45,
                            filled: true,
                            hintText: 'E-mail',
                            hintStyle: GoogleFonts.comfortaa(
                            fontSize: 15.0,
                            color: Colors.white,
                           letterSpacing: 4.0
                           ),
                  ),
                  style: TextStyle(
                    fontSize: 20.0, color: Colors.white),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 40.0),
                
                TextFormField(
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.white),
                  decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0))),
                    fillColor: Colors.black45,
                    filled: true,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.comfortaa(
                        fontSize: 15.0,
                        color: Colors.white,
                        letterSpacing: 4.0),
                ),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                            onTap:  () async {
                              if(_formKey.currentState.validate()){
                                setState(() => loading = true);
                                dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                Navigator.popAndPushNamed(context, '/home');
                                print(_auth.user);
                                if(result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Could not sign in with those credentials. Please check your E-mail';
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: 150.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.galada(
                                      fontSize: 27.0, color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                
                GestureDetector(
                  onTap: (){
                      Navigator.popAndPushNamed(context, '/register');
                    },
                    child: Text(
                    "Don't have an account?",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                )
            ],
          ),
        )),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      );
  
  }
}