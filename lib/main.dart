import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.purple,
      accentColor: Colors.purple,
    ),
    home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List myTodos = List();
  String input ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTodos.add("Task-1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My DayPlanner"),
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
                      setState(() {
                        myTodos.add(input);
                      });
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
      body: ListView.builder(
        itemCount: myTodos.length,
        itemBuilder: (BuildContext context, int i) {
          return Dismissible(
            key: Key(myTodos[i]),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)
              ),
              child: ListTile(
                title: Text(myTodos[i]),
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
      ),
    );
  }
}
