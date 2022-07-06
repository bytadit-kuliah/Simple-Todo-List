import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange)
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: deprecated_member_use
  List todos = [];
  String input = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todos.add("item1");
    todos.add("item2");
    todos.add("item3");
    todos.add("item4");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("mytodos"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context){
                final ButtonStyle flatButtonStyle = TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.all(0),
                  );
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: 
                  BorderRadius.circular(8)),
                  title: Text("Add TodoList"),
                  content: TextField(
                  onChanged: (String value){
                    input = value;
                  },
                ),
                
                actions: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: (){
                      setState(() {
                      todos.add(input);
                    });
                    Navigator.of(context).pop();
                  }, child: Text("Add"))
                ],   
              );
            });
          }, 
          child: Icon(
            Icons.add, 
            color: Colors.white,
          ),
        ),
        body: ListView.builder(
          itemCount: todos.length, 
          itemBuilder: (BuildContext context, int index){
            return Dismissible(
              key: Key(todos[index]), 
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(borderRadius: 
                BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(todos[index]), 
                  trailing: IconButton(icon: Icon(Icons.
                  delete, color: Colors.red,
                  ), 
                  onPressed: () {
                    setState(() {
                      todos.removeAt(index);
                    });
                  },),
              ),
            ));
        }),
    );
  }
}
