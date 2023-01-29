import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/task.dart';

class DataBaseHandler{
  DataBaseHandler();
  late Database database;

  void createDatabase() {
    openDatabase('todo.db',version: 1,
      onCreate: (database, version) {
        print('Database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value) {
          print('table created');
        }).catchError((error) {
          print("Error while creating table ${error.toString()}");
        });
      },
    ).then((value) => database = value);
  }

  List<Task> tasks =[];

  Future insertIntoDatabase(String title, String date, String time) async {
    return await database.transaction((txn) async{
      txn.rawInsert('INSERT INTO tasks (title, date, time) VALUES ("$title", "$time", "$date")').then((value) {
        print("$value inserted successfully");
    
      }).catchError((error) {
        print("Error while inserting record ${error.toString()}");
      });
      return null;
    });
  }

  Future getdb() async{
    return await database.rawQuery("SELECT * FROM tasks").then((value){
      tasks=[];
      value.forEach((element) {
        tasks.add(Task(element['title'].toString(), element['time'].toString(), element['date'].toString()));
      });
    }); //print(tasks[0].title);
  }
}