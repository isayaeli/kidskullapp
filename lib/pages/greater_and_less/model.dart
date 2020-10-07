import 'dart:convert';

class GreaterLessData{
  final id;
  final img;
  final int number;
  final int number2;
  final int number3;
  final int answer;
  final question;
   bool isDone;
   final audio;
   final audio2;
  GreaterLessData({
    this.img, this.number,
     this.number2, this.answer, 
     this.number3, this.question,this.id,
      this.isDone, this.audio, this.audio2});

 factory GreaterLessData.fromJson(Map<String, dynamic> json){
   return GreaterLessData(
     id: json['id'],
     number: json['first_number'],
     number2: json['second_number'],
     number3: json['third_number'],
     answer: json['answer'],
     question: json['question'],
     img: json['image'],
     isDone: json['isDone'],
     audio: json['audio'],
     audio2: json['audio2'],

   );
 

}
}












// List<GreaterLessData> data = [
//  GreaterLessData(
//    image:'images/1.jpeg',
//    number: 1,
//    number2:7,
//    number3: 5,
//    answer: 7,
//    question: 'Which is greater',
//    isDone: false
//  ),
//   GreaterLessData(
//    image:'images/2.jpg',
//     number: 4,
//     number2:7,
//     number3: 1,
//     answer: 1,
//     question: 'which is smaller',
//     isDone: false
//  ),
//   GreaterLessData(
//    image:'images/3.jpg',
//     number: 5,
//     number2:10,
//     number3: 6,
//     answer: 5,
//     question: 'Which is smaller',
//     isDone: false
//  )



// ];