import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidskulapp/pages/report/competition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<Album> createAlbum(String scores, String name) async {
  final http.Response response = await http.post(
    'http://10.0.2.2:8000/api/StudentsTrends/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'scores': scores,
      'name': name,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String scores;
  final String name;

  Album({this.id, this.scores, this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      scores: json['scores'],
      name: json['name'],
    );
  }
}

void main() {
  runApp(Report());
}

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PARENT REPORT',
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  SharedPreferencesDemo({Key key}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  //  final nameHolder = TextEditingController();
  Future<Album> _futureAlbum;

  clearTextInput(){
    _controller.clear();
    _controller2.clear();
 
  }
  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("PARENT REPORT"),
        backgroundColor: Colors.green,
        actions: [
//         Padding(padding: EdgeInsets.only(right:30),
//         child:  IconButton(
//            icon: Icon(Icons.add),
//             onPressed: _showDialog
//             ),
//         )
        ],
      ),
      body:Container(
        color:Colors.green,
        child: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        children:<Widget>[
          Container(
            color: Colors.orange,
            margin: EdgeInsets.all(15),
          child: FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Error: ${snapshot.error}'),);
                    } else {
                      return Container(
                        color:Colors.white,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            margin: EdgeInsets.all(10),
                            height :80,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.deepOrange,
                            child: Center(child: Text('Greater/Less exercise ',
                             style: TextStyle(fontSize: 20,color: Colors.white),
                            ),)
                          ),
                          SizedBox(height: 30,),
                          Padding(
                            padding: EdgeInsets.only(left:20),
                             child:Card(
                               elevation: 0,
                               color:Colors.white,
                               child: Text('This Student has Answerd ${snapshot.data} question${snapshot.data == 1 ? '' : 's'} correct ',
                                 style: TextStyle(fontWeight:FontWeight.bold,fontSize:16),
                               ),
                             ),
                          ),
                          SizedBox(height: 30,),

                          Padding(
                            padding: EdgeInsets.only(left:20),
                            child:Card(
                              elevation: 0,
                              color:Colors.white,
                              child: Text('This total score is ${snapshot.data}  ',
                                style: TextStyle(fontWeight:FontWeight.bold,fontSize:16),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),

                          Padding(
                            padding: EdgeInsets.only(left:20),
                            child:Card(
                              elevation: 0,
                              color:Colors.white,
                              child: snapshot.data >= 17? Text('The student is at Level 2',
                                style: TextStyle(fontWeight:FontWeight.bold,fontSize:16),
                              ):Text('The student is at level 1',
                                style: TextStyle(fontWeight:FontWeight.bold,fontSize:16),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),


                ]
                      )
                      );
                    }
                }
              })),
//              Container(
//                child: Text('Students Comptetion score\nPress the + button to submit score',
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17 )
//                ),
//              ),


//            Expanded(
//              child: Comptetion()
//            )


        ]
      ),
      )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
   
   _showDialog(){
     return showDialog(context: context,
     child: AlertDialog(
       
       content:Container(
         height: 170,
         child: Column(
         mainAxisAlignment:MainAxisAlignment.start,
         children:[
             TextField(
                      controller: _controller2,
                      decoration: InputDecoration(hintText: 'Enter name'),
                    ),
            TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Enter Score'),
                    ),
                    SizedBox(height:10),
                    RaisedButton(
                      child: Text('Submit Score'),
                      onPressed: () {
                        setState(() {
                          _futureAlbum = createAlbum(_controller.text, _controller2.text);
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                        clearTextInput();
                      },
                    ),
         ]
       ),
       ),
     ),
     );
   }



}




//ListTile(
//leading: Container(
//decoration: BoxDecoration(
//borderRadius:BorderRadius.circular(8),
//color:Colors.orange
//),
//height: 60,
//width: 100,
//child: Padding(padding: EdgeInsets.only(top:17,left: 7), child:Text('Greater/less',
//style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),)),
//),
//subtitle: Text('Scored ${snapshot.data} time${snapshot.data == 1 ? '' : 's'} correct'),
//title: Text('Total Correct answers.'),
//trailing:snapshot.data >= 17? Text('Level 2',
//style:TextStyle(fontWeight: FontWeight.bold)
//):Text('Level 1',
//style:TextStyle(fontWeight: FontWeight.bold)
//),
//),