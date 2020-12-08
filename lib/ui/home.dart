import 'package:flutter/material.dart';
import '../util/dbhelper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //UserModel user;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final DbHelper dbs = DbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'FSqlite CRUD Operation!',
          ),
          elevation: 0.0,
          backgroundColor: Colors.yellow[800],
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email ',
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.yellow[900],
                    child: Text('Insert'),
                    onPressed: () async {
                      int res = await dbs.insertDoc({
                        'name': nameController.text,
                        'email': emailController.text,
                      });
                      print("Resutl : $res");
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert Message"),
                            content:
                                Text('User Inserted : ${nameController.text}'),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.yellow[900],
                    child: Text('Read'),
                    onPressed: () async {
                      List<Map<String, dynamic>> list = await dbs.getDocs();
                      print("Before Display List$list");
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert Message"),
                            content: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Name : ${list[index]["name"].toString()}"),
                                        Text(
                                            "Email : ${list[index]['email'].toString()}"),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ]);
                                }),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );

                      print("After Display List");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.yellow[900],
                    child: Text('Update'),
                    onPressed: () async {
                      int res = await dbs.updateDoc({
                        'name': nameController.text,
                        'email': emailController.text,
                      });
                      print("Resutl : $res");
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert Message"),
                            content:
                                Text('User Updated : ${nameController.text}'),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.yellow[900],
                    child: Text('Delete'),
                    onPressed: () async {
                      int res = await dbs.deleteDoc(
                        nameController.text,
                      );
                      print("Resutl : $res");
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert Message"),
                            content:
                                Text('User Deleted : ${nameController.text}'),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
