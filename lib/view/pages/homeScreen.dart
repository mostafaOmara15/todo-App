// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/database_handling.dart';
import 'package:todo_app/view/widgets/container_of_task.dart';
import 'package:todo_app/view/widgets/form_field.dart';
import 'package:todo_app/view/widgets/used_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  bool buttom = false;

  DataBaseHandler DB = DataBaseHandler();

  @override
  void initState() {
    DB.createDatabase();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UsedColors.backScreenColor, 

      key: scaffoldkey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,

                  children: [
                    Text('Taskes for today',
                      style: TextStyle(fontSize: 30,color: UsedColors.textColor,fontWeight: FontWeight.bold),),

                    Text(DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    style: TextStyle(fontSize: 15,color: UsedColors.textColor,))
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              Expanded(
                child: Container(
                  color: UsedColors.backScreenColor,
                  child: ListView.builder(
                    itemCount: DB.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCard(task: DB.tasks[index]);
                    },
                  ),
                )
              )
            ],
          )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: UsedColors.themeColor,
        tooltip: 'New Task',
        child: buttom?Icon(Icons.add)
        :Icon(Icons.check),

        onPressed: () {
          if(buttom){
            if(formKey.currentState!.validate()){
              DB.insertIntoDatabase(titleCtrl.text, timeCtrl.text, dateCtrl.text);
              DB.getdb();
              print('form Done');
              Navigator.pop(context);
              titleCtrl.clear;
              timeCtrl.clear;
              dateCtrl.clear;

              setState(() {
                //DB.getdb();
              });
              
            }
          }else{
            scaffoldkey.currentState!.showBottomSheet((context) => Container(
              color:UsedColors.taskColor,
              padding: EdgeInsets.all(20.0),

              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    taskInfoField(
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "title must not be empty";
                        }
                        return null;
                      },
                      fieldController: titleCtrl,
                      lable: "Task title",
                      fieldIcon: Icon(Icons.title, color: UsedColors.themeColor,),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                    taskInfoField(
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "title must not be empty";
                        }
                        return null;
                      },
                      fieldController: timeCtrl,
                      lable: "Time",
                      fieldIcon: Icon(Icons.watch_later_outlined, color: UsedColors.themeColor,),
                      doing: (() {
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                          timeCtrl.text = value!.format(context).toString();
                          print(value.format(context));
                        });
                      })
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                    taskInfoField(
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "title must not be empty";
                        }
                        return null;
                      },
                      fieldController: dateCtrl,
                      lable: "Date",
                      fieldIcon: Icon(Icons.calendar_month_outlined, color: UsedColors.themeColor,),
                      doing: (() {
                        showDatePicker(
                          context: context, 
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2022-12-31')
                        ).then((value) {
                          dateCtrl.text =DateFormat.yMMMd().format(value!);
                        });
                      })
                    ),
                  ],
                )
              ),
            ));
          }
          buttom = !buttom;
        },
      ),
    );
  }
}