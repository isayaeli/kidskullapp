import 'dart:convert';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kidskulapp/pages/reading/reading_model.dart';

class Reading extends StatefulWidget {
  @override
  _ReadingState createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {

  AudioPlayer audioPlayer = AudioPlayer();

  Future<List<VowelData>> _fetchData(http.Client client) async {
    var response = await client.get('http://10.0.2.2:8000/api/vowels');
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((voweldata)=> VowelData.fromJson(voweldata)).toList();
    }else{
      throw Exception('faild to get data');
    }
  }
   int counter = 0;
   void score(){
     setState(() {
       counter++;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Vowels'),
        actions: <Widget>[
          Padding(padding: EdgeInsets.only(top:20, right:40),
           child: Text('Score $counter',
           style: TextStyle(fontWeight: FontWeight.bold),
           ),
          )
        ],
      ),
      body: Container(
      color:Colors.greenAccent,
      child: FutureBuilder(
        future: _fetchData(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          List<VowelData> data = snapshot.data;
          if( snapshot.hasData){
            return GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
             itemBuilder: (context, i){
               return InkWell(
                 onTap: () async{
                   await audioPlayer.play(data[i].audio);
                   score();
                 },
                 child: Card(
                   child:Container(
                     decoration:BoxDecoration(
                       image:DecorationImage(image: NetworkImage(data[i].img))
                     ),
                     child: Center(
                       child:Column(
                         children:[
                           Text(data[i].vowel,
                       style:TextStyle(color: Colors.red, fontSize:30)
                       
                       ),
                         ]
                       )
                     ),
                   )
                 ),
               );
             }
             );
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    ),
    );
  }
}