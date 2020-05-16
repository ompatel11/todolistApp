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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                  color: Colors.cyanAccent[400],
                ),
                height: MediaQuery.of(context).size.height * 0.45,
                
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xff202020),
                  ),
                  child:Container(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                  'Register',
                  style: GoogleFonts.galada(
                      color: Colors.cyanAccent,
                      fontSize: 40.0,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
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
              SizedBox(height: 30.0),
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
              SizedBox(height: 30.0),
              GestureDetector(
                onTap:() async {
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
                } ,
                            child: Container(
                              width: 150.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent[400],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: GoogleFonts.galada(
                                      fontSize: 27.0, color: Colors.black45),
                                ),
                              ),
                            ),
                          ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                
                GestureDetector(
                  onTap: (){
                    Navigator.popAndPushNamed(context, '/login');
                    },
                    child: Text(
                    "Already have an account?",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.cyanAccent
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
              )
            ),
          )
        ],
      )
    );
  }
}