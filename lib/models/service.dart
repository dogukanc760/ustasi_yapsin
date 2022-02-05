class Service {
  String user;
  String name;
  String companyName;
  List<String> sector;
  List<String> category;
  List<String> city;
  List<String> distinct;
  List<String> questions;
  List<String> answer;
  String title;
  String description;
  int price;
  int priceTwo;
  String personCount;
  String img;
  List<String> descImg;
  List<String> descVideos;
  int rating;
  int ratingCount;
  List<String> comments;
  String about;

  Service({required this.user, required this.name, required this.companyName, required this.sector, required this.category,
  required this.city, required this.distinct, required this.questions, required this.answer, required this.title,
  required this.description, required this.price, required this.priceTwo, required this.personCount, required this.img,
  required this.descImg, required this.descVideos, required this.rating, required this.ratingCount, required this.about,
    required this.comments});
  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
      answer: json['answer'],
      category: json['category'],
      price: json['price'],
      city: json['city'],
      user: json['user'],
      description: json['description'],
      about: json['about'],
      comments: json['comments'],
      companyName: json['companyName'],
      descImg: json['descImg'],
      descVideos: json['descVideos'],
      distinct: json['distinct'],
      img: json['img'],
      name: json['name'],
      personCount: json['personCount'],
      priceTwo: json['priceTwo'],
      questions: json['questions'],
      rating: json['rating'],
      ratingCount: json['ratingCount'],
      sector: json['sector'],
      title: json['title']

    );}


}