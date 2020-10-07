
class GreaterLessDataL2{
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
  GreaterLessDataL2({
    this.img, this.number,
     this.number2, this.answer, 
     this.number3, this.question,this.id,
      this.isDone, this.audio, this.audio2});

 factory GreaterLessDataL2.fromJson(Map<String, dynamic> json){
   return GreaterLessDataL2(
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