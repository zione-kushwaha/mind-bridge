import 'package:flutter/material.dart';

class todoView extends StatefulWidget {
  const todoView({super.key});

  @override
  State<todoView> createState() => _todoViewState();
}

class _todoViewState extends State<todoView> {
  List todoList = [];
  String singlevalue = "";

  addString(content) {
    setState(() {
      singlevalue = content;
    });
  }

  addList() {
    setState(() {
      todoList.add({"value": singlevalue});
    });
  }

  deleteItem(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.blue[900],
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 80,
                              child: Text(
                                todoList[index]['value'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  deleteItem(index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Row(
            children: [
              Expanded(
                flex: 70,
                child: Container(
                  height: 40,
                  child: TextFormField(
                    onChanged: (content) {
                      addString(content);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fillColor: Colors.blue[300],
                        filled: true,
                        labelText: 'Create Task....',
                        labelStyle: TextStyle(
                          color: Colors.indigo[900],
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: 5,
                  )),
              ElevatedButton(
                onPressed: () {
                  addList();
                },
                child: Container(
                    height: 15,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text("Add")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
