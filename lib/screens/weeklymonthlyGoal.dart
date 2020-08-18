import 'package:flutter/material.dart';

class Goals extends StatefulWidget {
  final String appTitle;

  Goals({Key key,this.appTitle}) : super(key:key);

  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  List myTodos = List();
  String input ;

  createTask() {
    DocumentReference docRef = Firestore.instance.collection("WeeklyGoals").document(input);
    Map<String,String> tasks = {"TaskTitle":input};
    docRef.setData(tasks).whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appTitle),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  title: Text("Add Task"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: (){
                        createTask();
                        Navigator.of(context).pop();
                      },
                      child: Text("Add"),
                    ),
                  ],
                );
              } );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(stream: Firestore.instance.collection("WeeklyGoals").snapshots(),
        builder: (context,snapshots){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data.documents.length,
            itemBuilder: (context, i) {
              DocumentSnapshot docSnap = snapshots.data.documents[i];
              return Dismissible(
                key: Key(i.toString()),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                  ),
                  child: ListTile(
                    title: Text(docSnap["TaskTitle"]),
                    trailing: IconButton(icon: Icon(Icons.delete,
                        color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          myTodos.removeAt(i);
                        });
                      },),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
