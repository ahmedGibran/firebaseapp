import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/home.dart';
import 'package:firebaseapp/phone_auth.dart';
import 'package:firebaseapp/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _login(BuildContext context)async
  {
   if(_passwordController.text.isNotEmpty&&_emailController.text.isNotEmpty){
     AuthResult result =
         await _auth.signInWithEmailAndPassword(
             email: _emailController.text,
             password: _passwordController.text);
     FirebaseUser user = result.user;
     if(user!=null){
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
     }
   }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
          body: Padding(
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
                 _login(context);
                },
                  color: Theme.of(context).primaryColor,
                child: Text("Login",style: TextStyle(color: Colors.white),),),
                SizedBox(height: 8,),
                RaisedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>PhoneAuth()));
                },
                  color: Theme.of(context).primaryColor,
                  child: Text("SMS",style: TextStyle(color: Colors.white),),),
                SizedBox(height: 10,),
                FlatButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Register()));
                },
                  child: Text("Register",style: TextStyle(color: Theme.of(context).primaryColor),),),
              ],
            ),
          ),
    );
  }

}
