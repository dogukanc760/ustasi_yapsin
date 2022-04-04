class Conversations{
  List<String> members;
  String convId;
  String targetName;

  Conversations({required this.members, required this.targetName,required this.convId,});

  factory Conversations.fromJson(Map<String, dynamic> json){
    return Conversations(
      targetName: json['targetName'],
      members: json['members'],
      convId: json['convId'],
    );}
  Map<String, String> toJson() =>
      {
        //'members':members,
        'convId':convId,
       
      };
}