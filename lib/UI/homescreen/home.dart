import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:prsenentaion_firebase/UI/Auth/profile/profile.dart';
import 'package:prsenentaion_firebase/UI/homescreen/addtask.dart';
import 'package:prsenentaion_firebase/UI/homescreen/update.dart';
import 'package:prsenentaion_firebase/util/colors.dart';
import 'package:prsenentaion_firebase/util/flutter_toast.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchcontroller = TextEditingController();
  final db = FirebaseDatabase.instance.ref('todo');
  final database = FirebaseDatabase.instance
      .ref('todo')
      .orderByChild('uid')
      .equalTo(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pro_Color.main_light_color,
      appBar: AppBar(
        backgroundColor: Pro_Color.backcolor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: Icon(Icons.person),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        backgroundColor: Pro_Color.backcolor,
        child: Icon(
          Icons.arrow_forward,
          color: Pro_Color.main_dark_color,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(120),
                    bottomRight: Radius.circular(0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('     TODOEY',
                    style: TextStyle(
                        color: Pro_Color.main_light_color,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                Image.asset(
                  'asset/pink_notebook.jpeg',
                  height: 60,
                  width: 60,
                )
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 38,
              width: 500,
              child: TextField(
                controller: searchcontroller,
                onChanged: (v) {
                  setState(() {});
                },
                style: TextStyle(
                  fontSize: 16,
                  color: Pro_Color.main_light_color,
                ),
                decoration: InputDecoration(
                  labelText: '',
                  hintText: 'search',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Pro_Color.main_dark_color,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Pro_Color.main_light_color,
                    ),
                    onPressed: () {
                      // Add your search functionality here
                      print('Search icon pressed');
                    },
                  ),
                ),
              ),
            ),
        
        
        
        
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: database,
                itemBuilder: (context, snapshot, Animation, index) {
                  if (snapshot
                      .child('title')
                      .value
                      .toString()
                      .contains(searchcontroller.text.toString())) {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.child('title').value}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${snapshot.child('description').value}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: 100,
                              // ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateTask(
                                                        title: snapshot
                                                            .child('title')
                                                            .value,
                                                        description: snapshot
                                                            .child(
                                                                'description')
                                                            .value,
                                                        id: snapshot
                                                            .child('id')
                                                            .value,
                                                      )));
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          db
                                              .child(snapshot.key!)
                                              .remove()
                                              .then((v) {
                                            fluttertoas().showpopup(
                                                Pro_Color.main_dark_color,
                                                'Delete successfully!');
                                          }).onError((error, v) {
                                            fluttertoas().showpopup(
                                                Colors.red, error.toString());
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Pro_Color.main_light_color,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
                  } else if (searchcontroller.text.isEmpty) {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.child('title').value}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${snapshot.child('description').value}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: 100,
                              // ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateTask(
                                                        title: snapshot
                                                            .child('title')
                                                            .value,
                                                        description: snapshot
                                                            .child(
                                                                'description')
                                                            .value,
                                                        id: snapshot
                                                            .child('id')
                                                            .value,
                                                      )));
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          db
                                              .child(snapshot.key!)
                                              .remove()
                                              .then((v) {
                                            fluttertoas().showpopup(Colors.blue,
                                                'Delete successfully!');
                                          }).onError((error, v) {
                                            fluttertoas().showpopup(
                                                Colors.red, error.toString());
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Pro_Color.main_light_color,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }
}
