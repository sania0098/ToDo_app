import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prsenentaion_firebase/util/colors.dart';
import 'package:prsenentaion_firebase/util/flutter_toast.dart';
import 'package:prsenentaion_firebase/widget/CustomButton.dart';
import 'package:prsenentaion_firebase/widget/textfield_button.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key, this.title, this.description, this.id});

  final title;
  final description;
  final id;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController titleController = TextEditingController(
    text: 'title',
  );

  TextEditingController descriptionController = TextEditingController(
    text: 'description',
  );

  final database = FirebaseDatabase.instance.ref('todo');
  bool is_loading = false;
  function() {
    print('Title data: ${titleController.text.trim()}');
    print('Description data: ${descriptionController.text.trim()}');
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

      database.child(widget.id).update({
        'title': titleController.text.trim().toString(),
        'description': descriptionController.text.trim().toString(),
      }).then((v) {
        fluttertoas()
            .showpopup(Pro_Color.main_dark_color, ' Task add successfully!');
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
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    return Scaffold(
      backgroundColor: Pro_Color.backcolor,
      appBar: AppBar(
        title: Text(
          'Update screen',
          style: TextStyle(color: Colors.black),
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
                    // child: ClipRRect(
                    //     child: Image.asset(
                    //   'asset/pink_layers.jpeg',
                    //   fit: BoxFit.cover,
                    // )),
                    child: Center(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Task',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Lets Edit This Task',
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
                        hinttext: '',
                        labeltext: 'Task'),
                    SizedBox(height: 20),
                    textfield_widget(
                        Controller: descriptionController,
                        hinttext: '',
                        labeltext: 'Description'),
                    SizedBox(height: 20),
                    Custombutton(
                      text: 'Update Task',
                      color: Pro_Color.main_light_color,
                      onTap: function,
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
