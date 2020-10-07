class CountData {
  final String number;
  final String img;
  final String audio;
  
  CountData({this.number, this.img, this.audio});
  
  factory CountData.fromJson(Map<String, dynamic> json){
   return CountData(
     number: json['number'],
     img: json['image'],
     audio: json['audio'],

   );


}
}

// List<CountData> data = [
  
//   CountData(
//     number:'1',
//     image: 'images/1.jpeg'
//   ),
//    CountData(
//     number:'2',
//     image: 'images/3.jpg'
//   ),
//    CountData(
//     number:'3',
//     image: 'images/2.jpg'
//   ),
//   CountData(
//     number:'4',
//     image: 'images/4.jpg'
//   ),
//    CountData(
//     number:'5',
//     image: 'images/5.png'
//   ),
//    CountData(
//     number:'6',
//     image: 'images/6.jpeg'
//   ),
//   CountData(
//     number:'7',
//     image: 'images/7.png'
//   ),
//    CountData(
//     number:'8',
//     image: 'images/2.jpg'
//   ),
//    CountData(
//     number:'9',
//     image: 'images/3.jpg'
//   ),
//   CountDa