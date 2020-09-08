import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/home.dart';
import 'package:flutter/material.dart';
class PhoneAuth extends StatelessWidget {
  TextEditingController _phoneController= TextEditingController();
  TextEditingController _codeController= TextEditingController();
  Future<void> _smsLogin(BuildContext context)async{
    FirebaseAuth _auth= FirebaseAuth.instance;
   try{
     _auth.verifyPhoneNumber(
         phoneNumber: _phoneController.text,
         timeout: Duration(seconds: 60),
         verificationCompleted: (AuthCredential credential)async{
           Navigator.of(context).pop();
           AuthResult result =
           await _auth.signInWithCredential(credential);
           FirebaseUser user = result.user;
           if(user!=null){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
           }
         },
         verificationFailed: (AuthException e){
           print("Error$e");
         },
         codeSent: (String verificationId,[int forceResendingToken]){
           showDialog(context: context,
               barrierDismissible: false,
               builder: (context)=>AlertDialog(
                 title: Text("Input Code"),
                 content: Container(
                   width: MediaQuery.of(context).size.width-20,
                   height: 70,
                   child: TextField(
                     controller:_codeController ,
                   ),
                 ),
                 actions: <Widget>[
                   FlatButton(onPressed: ()async{
                     AuthCredential credential
                     = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: _codeController.text);
                     AuthResult result =
                     await _auth.signInWithCredential(credential);
                     FirebaseUser user = result.user;
                     if(user!=null){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                     }
                   },
                     child: Text("Confirm",style: TextStyle(color: Colors.white),),
                     color: Theme.of(context).accentColor,
                   )
                 ],
               )
           );
         },
         codeAutoRetrievalTimeout: null
     );
   }catch(e){
     print("Error$e");

   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:  Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.phone_android),
                hintText: 'Phone',
                // labelText: 'Name *',
              ),
              controller: _phoneController,

            ),
            SizedBox(height: 30,),
            RaisedButton(onPressed: (){
              _smsLogin(context);
            },
              color: Theme.of(context).primaryColor,
              child: Text("Confirm",style: TextStyle(color: Colors.white),),),
          ],
        ),
      ),
    );
  }
}
