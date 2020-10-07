
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<Album> createAlbum(bool isDone) async {
  final http.Response response = await http.post(
    'http://10.0.2.2:8000/api/GreaterLess/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'isDone': isDone.toString(),
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  bool isDone;


  Album({this.isDone});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      isDone: json['isDone']
    );
  }
}







