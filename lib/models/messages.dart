class Message{
  String text;
  String convId;
  String sender;

  Message({required this.text, required this.sender,required this.convId,});

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      text: json['text'],
      sender: json['sender'],
      convId: json['convId'],
    );}
  Map<String, String> toJson() =>
      {
        //'members':members,
        'convId':convId,
       
      };
}