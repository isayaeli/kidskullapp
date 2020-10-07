import 'package:flutter/material.dart';
import 'package:kidskulapp/pages/counting.dart';
import 'package:kidskulapp/pages/greater_and_less/greater_less.dart';
import 'package:kidskulapp/pages/reading/reading.dart';
import 'package:kidskulapp/pages/witter/writter.dart';
class Lesson extends StatefulWidget {
  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title:Text('Lessons'),
        backgroundColor:Colors.deepPurple
      ),
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image:AssetImage('images/1.jpeg')
          )
        ),
        child:ListView(
          children:<Widget>[
            SizedBox(height:50),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                Container(
                  color: Colors.yellow,
                  width: 150,
                  height: 100,
                  child:InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Counting())),
                    child:Card(
                    child:Center(
                      child:Padding(padding: EdgeInsets.only(left:8, right:8),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Counting',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('1 to 10',
                           style: TextStyle(fontWeight: FontWeight.bold)
                          )
                        ],
                      ),
                      )
                      )
                  )
                  )
                ),
                Container(
                  color: Colors.greenAccent,
                  width: 150,
                  height: 100,
                  child:InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Reading())),
                    child: Card(
                    child:Center(
                      child:Padding(padding: EdgeInsets.only(left:8, right:8),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Reading',
                           style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                          Text('Vowels',
                          style: TextStyle(fontWeight: FontWeight.bold)
                          )
                        ],
                      ),
                      )
                      )
                  ),
                  )
                ),
         
              ]
            ),


            // The second row of exercises
            // SizedBox(height:200),
            // Row(
            //   mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            //   children:<Widget>[
            //     Container(
            //       color: Colors.orange,
            //       width: 150,
            //       height: 100,
            //       child:InkWell(
            //         onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Greater_and_Less())),
            //         child:Card(
            //         child:Center(
            //           child:Padding(padding: EdgeInsets.only(left:8, right:8),
            //           child: Column(
            //             mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            //             children: <Widget>[
            //               Text('Greater/less Than',
            //               style: TextStyle(fontWeight: FontWeight.bold),
            //               ),
            //               Text('>/<',
            //                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            //               )
            //             ],
            //           ),
            //           )
            //           )
            //       )
            //       )
            //     ),
            //     Container(
            //       color: Colors.blueAccent,
            //       width: 150,
            //       height: 100,
            //       child:InkWell(
            //         onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Writter())),
            //         child: Card(
            //         child:Center(
            //           child:Padding(padding: EdgeInsets.only(left:8, right:8),
            //           child: Column(
            //             mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            //             children: <Widget>[
            //               Text('Learning ',
            //                style: TextStyle(fontWeight: FontWeight.bold)
            //               ),
            //               Text('To write',
            //               style: TextStyle(fontWeight: FontWeight.bold)
            //               )
            //             ],
            //           ),
            //           )
            //           )
            //       ),
            //       )
            //     ),
         
            //   ]
            // )
            // The second row ends here
          ]
        )
      ),
    );
  }
}