import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Register extends StatelessWidget {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _register(BuildContext context) async{
     if(_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty){
       AuthResult result =
           await _auth.createUserWithEmailAndPassword(
               email: _emailController.text,
               password: _passwordController.text);
       FirebaseUser user = result.user;
       if(user!=null){
         ///
         ///
         Navigator.of(context).pop();
       }else{

       }
     }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Email',
                // labelText: 'Name *',
              ),
              controller: _emailController,
              onChanged: (value){
                _emailController.text=value;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.vpn_key),
                hintText: 'password',
                // labelText: 'Name *',
              ),
              controller: _passwordController,
              onChanged: (value){
                _passwordController.text=value;
              },
            ),
            SizedBox(height: 30,),
            RaisedButton(onPressed: (){
              _register(context);
            },
              color: Theme.of(context).primaryColor,
              child: Text("Register",style: TextStyle(color: Colors.white),),),
            SizedBox(height: 10,),
            FlatButton(onPressed: (){
              Navigator.of(context).pop();

            },
              child: Text("Login",style: TextStyle(color: Theme.of(context).primaryColor),),),
          ],
        ),
      ),
    );
  }
}
