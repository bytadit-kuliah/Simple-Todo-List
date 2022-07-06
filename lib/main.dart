import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  createTodos(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyTodolist").doc(input);

    // Map
    Map<String, String> todos = {
      "todoTitle": input
    };

    // DocumentReference.setData(todos).whenComplete((){
    //   print("$input created");
    // });
  
  }

  deleteTodos(){

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
                    //   setState(() {
                    //   todos.add(input);
                    // });
                    createTodos();
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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("MyTodolist").snapshots(),
          builder: (context, 
          AsyncSnapshot snapshots) {
          return  ListView.builder(
            shrinkWrap: true,
          itemCount: snapshots.data.docs.length, 
          itemBuilder: (context, index){
            DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
            return Dismissible(
              key: Key(index.toString()), 
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(borderRadius: 
                BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(documentSnapshot["todoTitle"]), 
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
        });
      }),
    );
  }
}
