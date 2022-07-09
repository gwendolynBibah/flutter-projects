import 'package:flutter/material.dart';
import 'main.dart';

class ToDoUI extends StatefulWidget {
  const ToDoUI({Key? key}) : super(key: key);

  @override
  State<ToDoUI> createState() => _ToDoUIState();
}

class _ToDoUIState extends State<ToDoUI> {
  //controller for add button text field
  final taskController = TextEditingController();
  //for validation
  bool txtValidate = true;
  late String errTxt ;
//for task input
  late String addTask;
  List<String> listItem = [];
  Widget listItemDecoration(listItem) {
    return Card(
      color: Colors.deepOrange[400],
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            title: Text(
              taskController.text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {},
          )),
    );
  }

  void taskInputDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Center(
                child: Text(
                  "Add Task",
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: taskController,
                    autofocus: true,
                    // decoration: InputDecoration(
                    //   errorText: txtValidate ? null : errTxt
                    // ),                   
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              //should take the text in the box and display it in the card
                              setState((){
                              listItem.add(taskController.text);
                              taskController.clear();                            
                              txtValidate = true;
                              });
                             
                              //to validate
                              if(taskController.text.isEmpty){
                                setState((){
                                  errTxt = "Can't Add Empty Space";
                                  txtValidate = false;
                                });
                              } else if (taskController.text.length > 120){
                                setState(() {
                                  errTxt = "Too Many Characters";
                                  txtValidate = false;
                                },);
                              }
                              
                            },
                            child: Text("Add")),
                      )
                    ],
                  )
                ],
              ));
            });
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do App"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[900],
      ),
      backgroundColor: Colors.deepOrange[200],
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: taskInputDialog,
        backgroundColor: Colors.deepOrange[900],
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(listItem[index]),
                  );
                }, 
                separatorBuilder: (BuildContext context, int index)=> Divider(
                  color: Colors.deepOrange[600],
                ),
                 itemCount: listItem.length
                 ),
            ),
          )
    ])
    );
  }
}