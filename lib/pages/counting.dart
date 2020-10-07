import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kidskulapp/pages/count_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
class Counting extends StatefulWidget {
  @override
  _CountingState createState() => _CountingState();
}

class _CountingState extends State<Counting> {
  AudioPlayer audioPlayer = AudioPlayer();

  
   Future<List<CountData>> _fetchData(http.Client client) async {
    var response =  await client.get('http://10.0.2.2:8000/api/counting');
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((countdata) => CountData.fromJson(countdata)).toList();
    }else{
      throw Exception('Failed to get data');
    }
 
  }
  // @override
  // void initState() {
  //   audioPlayer.play('http://10.0.2.2:8000/media/count_to10_audios/Mark_U_My_Heart_Knows_Official_Video_.mp3');
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.yellow,
        child:FutureBuilder(
          future:_fetchData(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              List<CountData> data = snapshot.data;
              return GridView.builder(
                itemCount: data.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                 itemBuilder: (context, i){
                 return InkWell(
              onTap:() async {
                await audioPlayer.play(data[i].audio,);
              },
              child: Card(
              color: Colors.cyan,
              child:Container(
                decoration:BoxDecoration(image: DecorationImage(image: NetworkImage(data[i].img))),
                child:Center(
               child:Text(data[i].number,
             style:TextStyle(fontWeight: FontWeight.bold, fontSize:35)
             )
             ) 
              ),
            )
            );
          }
          );
            } else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ),
    );
  }
}

























// GridView(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//           children: <Widget>[
//            Card(
//              color:Colors.cyan,
//              child: Center(
//                child:Text('1',
//              style:TextStyle(fontWeight: FontWeight.bold, fontSize:35)
//              )
//              )
//            ),
//             Card(
//              color:Colors.cyan
//            ),
//             Card(
//              color:Colors.cyan
//            ),
//             Card(
//              color:Colors.cyan
//            )
//           ],)