import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kidskulapp/pages/exercise.dart';
import 'package:kidskulapp/pages/home.dart';
import 'package:kidskulapp/pages/lessons/lessson.dart';
import 'package:kidskulapp/pages/report/report.dart';


class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: BoxDecoration(
          image:DecorationImage(
                  image:AssetImage('images/7.png'),
                  fit: BoxFit.cover
                )
        ),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              height: 380,
              
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(50),bottomRight:Radius.circular(50)),
                image:DecorationImage(
                  image:AssetImage('images/2.jpg'),
                  fit: BoxFit.cover
                ),
              ),
            ),
            SizedBox(height:40),
             Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children:<Widget>[
               Container(
                 height:100,
                 width:150,
                 child:InkWell(
                   onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Video())),
                   child: Card(color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     Center(child: FaIcon(FontAwesomeIcons.youtube, color: Colors.white,),),
                    Center(child: Text('Videos',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 20),
                    ),)
                  ],
                )
                ),
                 )
               ),
               InkWell(
                 onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Exersice())),
                 child:Container(
                 height:100,
                 width:150,
                 child: Card(color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     Center(child: IconButton(icon: FaIcon(FontAwesomeIcons.book,color: Colors.white),
                      onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Exersice()))),),
                    Center(child: Text('Exercises',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 20),
                    ),)
                  ],
                )
                )
               ),
               ),
               
              ]
            ),

              SizedBox(height:20),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Report())),
                  child: Container(
                 height:100,
                 width:150,
                 child: Card(color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     Center(child: FaIcon(FontAwesomeIcons.receipt, color: Colors.white,),),
                    Center(child: Text('Report',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                    ),)
                  ],
                )
                )
               ),
                ),
                 InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Lesson())),
                  child: Container(
                 height:100,
                 width:150,
                 child: Card(color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     Center(child: FaIcon(FontAwesomeIcons.bookOpen, color: Colors.white,),),
                    Center(child: Text('Lessons',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                    ),)
                  ],
                )
                )
               ),
                )
               ],
            ),        
          ],
        )
      ),
    );
  }
}




