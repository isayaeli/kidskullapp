import 'package:flutter/material.dart';
import 'package:kidskulapp/pages/nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'kidskul',
        debugShowCheckedModeBanner: false,
        home: Welcome(),
    );
  }
}

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool userIn = false;
  bool isLoaging = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _handleSignIn() async {
  GoogleSignInAccount googleUser = await googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  FirebaseUser user = authResult.user;
  print("signed in " + user.displayName);

  setState(() {
    userIn = true;
  
  });

 setState(() {
   isLoaging =true;
 });

  return user;

}


 void _signOut(){
   googleSignIn.signOut();
   print('user sign out');
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
        height: MediaQuery.of(context).size.height,
         decoration: BoxDecoration(
           image:DecorationImage(
             image:AssetImage('images/2.jpg'),
             fit:BoxFit.contain
           ),
         ),
         child: Container(
           height: 100,
           margin:EdgeInsets.only(top:300),
           color:Colors.transparent,
           child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
           Container(
            //  child:Text('Welcome kid click the arroe to continue',
            //   style: TextStyle( fontFamily: 'Modak-Regular', fontSize: 20,color: Colors.green),
            //  )
           ),
           Expanded(child: Container(
            margin: EdgeInsets.only(top: 300),
             width: 400,
             decoration: BoxDecoration(
               color:Colors.transparent,
               borderRadius: BorderRadius.circular(2)
             ),
             child: Padding(
               padding:EdgeInsets.only(top:0),
              //  child:userIn? RaisedButton(onPressed: (){
              //    _signOut();
              //   //  Navigator.of(context).pop(true);
              //  },
              //  child: Text('Sign out'),
              //  color: Colors.blue,
              //  ):RaisedButton(onPressed: ()=> _handleSignIn().then((FirebaseUser user)=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Nav()))),
              //  child: Text('Sign In'),
              //  color: Colors.blue,
              // ),
               child:IconButton(icon:FaIcon(FontAwesomeIcons.arrowRight),
             tooltip: 'next',color: Colors.red, 
             onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Nav()))
            //  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Nav()))
             ),
             )
           ))
         ],
        ), 
         ),
    ),
    );
  }
}



