import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:kidskulapp/pages/report/modal.dart';


 class Comptetion extends StatefulWidget {
   @override
   _ComptetionState createState() => _ComptetionState();
 }

 class _ComptetionState extends State<Comptetion> {

     Future<List<CompeteData>> _fetchData(http.Client client) async {
    var response =  await client.get('http://10.0.2.2:8000/api/GreaterLess/');
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((countdata) => CompeteData.fromJson(countdata)).toList();
    }else{
      throw Exception('Failed to get data');
    }

  }


   @override
   Widget build(BuildContext context) {
     return Container(
          height: 350,

        child: FutureBuilder(
          future: _fetchData(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot){
             if(snapshot.hasData){
                List<CompeteData> data = snapshot.data;
               return ListView.builder(
                 itemCount:data.length,
                 itemBuilder: (context, i){
                   return Card(
                     color:Colors.transparent,
                     elevation:2,
                     child:ListTile(
                     title: Text(data[i].name,
                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                     ),
                     subtitle: Text(data[i].scores,
                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                     ),
                   )
                   );
                 },
               );
             }else if(snapshot.hasError){
               return Center(child:Text('${snapshot.error}'));
             }else{
               return Center(child: CircularProgressIndicator(),);
             }
          },
        ),
     );
   }
 }