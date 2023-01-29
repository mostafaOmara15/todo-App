import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/view/widgets/used_colors.dart';

class TaskCard extends StatefulWidget {

  Task task;
  TaskCard({required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: UsedColors.taskColor
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: UsedColors.themeColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),

                    Expanded(
                      child: Text(widget.task.title,style: TextStyle(color: isChecked == false? Colors.white : Colors.grey, fontSize: 28),)
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.task.time,style: TextStyle(color: UsedColors.supTextColor, fontSize: 18),),
                    Text(widget.task.date,style: TextStyle(color: UsedColors.supTextColor, fontSize: 18),),
                  ],
                )
              ]
            ),
          ),
          onLongPress: () {},
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
      ],
    );
  }
} 