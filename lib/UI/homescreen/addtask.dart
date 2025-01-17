import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prsenentaion_firebase/util/colors.dart';
import 'package:prsenentaion_firebase/util/flutter_toast.dart';
import 'package:prsenentaion_firebase/widget/CustomButton.dart';
import 'package:prsenentaion_firebase/widget/textfield_button.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final database = FirebaseDatabase.instance.ref('todo');
  bool is_loading = false;
  fun() {
    if (titleController.text.isEmpty) {
      fluttertoas().showpopup(
        Colors.red,
        'Please enter the title of the task',
      );
    } else if (descriptionController.text.isEmpty) {
      fluttertoas().showpopup(
        Colors.red,
        'Please enter the description of the task',
      );
    } else {
      is_loading = true;
      setState(() {});
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      database.child(id).set({
        'title': titleController.text.trim().toString(),
        'description': descriptionController.text.trim().toString(),
        'id': id,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      }).then((v) {
        fluttertoas()
            .showpopup(Pro_Color.main_light_color, ' Task add successfully!');
        titleController.clear();
        descriptionController.clear();
        is_loading = false;
        setState(() {});
        Navigator.pop(context);
      }).onError((error, v) {
        is_loading = false;
        setState(() {});
        fluttertoas().showpopup(Colors.red, 'Error  $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pro_Color.backcolor,
      appBar: AppBar(
        backgroundColor: Pro_Color.backcolor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Welcome Section
              Row(
                children: [
                  Container(
                    height: 250,
                    width: 360,
                    decoration: BoxDecoration(
                      color: Pro_Color.main_light_color,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(150),
                        bottomLeft: Radius.circular(150),
                      ),
                    ),
                    child: Center(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Task',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Add a New Task to Your To-Do List',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    textfield_widget(
                        Controller: titleController,
                        hinttext: 'Enter task',
                        labeltext: 'Task'),
                    SizedBox(height: 20),
                    textfield_widget(
                        Controller: descriptionController,
                        hinttext: ' Enter Description',
                        labeltext: 'Description'),
                    SizedBox(height: 20),
                    Custombutton(
                      text: 'Add Task',
                      color: Pro_Color.main_light_color,
                      onTap: fun,
                      is_loading: is_loading,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
