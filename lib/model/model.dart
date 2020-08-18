class Goal{
  int id;
  String text;

  Goal({this.id,this.text});

  Map<String,dynamic> toMap() => {
    "id":id,
    "text":text,
  };

  factory Goal.fromMap(Map<String,dynamic> json) => new Goal(
    id : json["id"],
    text: json["text"]
  );
}