// ignore_for_file: deprecated_member_use

import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  //SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email ='';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon( 
            icon: Icon(Icons.person),
             label: Text('Register'),
             onPressed: (){
              widget.toggleView();
             },
             )
        ],
      ),
      body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget> [
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith( hintText: 'Email'),
                    validator: (val) =>
                              val!.isEmpty ? "Enter an email" : null,
                    onChanged: (val){
                      setState(() => email = val);
      
                    }
                  ),
      
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith( hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                              ? "Enter a password 6+ chars long"
                              : null,
                    onChanged: (val){
                       setState(() => password = val);
                    }
                  ),
      
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                       if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.signInWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'could not sign in with those credential';
                                  
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
              )
      ),
    );
  }
}