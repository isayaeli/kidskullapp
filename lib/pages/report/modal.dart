import 'dart:convert';

class CompeteData {
  final scores;
  final name;

  CompeteData({this.scores,this.name});
  
  factory CompeteData.fromJson(Map<String, dynamic>json){
    return CompeteData(
      scores: json['scores'],
      name: json['name']
    );
  }

}