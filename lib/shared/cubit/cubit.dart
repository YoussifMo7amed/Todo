import 'package:TodoApp/modules/All.dart';
import 'package:TodoApp/modules/completed.dart';
import 'package:TodoApp/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoInitialstate());
  static TodoCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    ALL(),
    completed(),
  ];
  Database? database;
  int currentIndex = 0;
  var titlecontroller = TextEditingController();
  var detailscontroller = TextEditingController();
  List<Map> Newtasks = [];
  List<Map> Donetasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(changeTodoNavBarstate());
  }

  void createdatabase() {
    if (database == null) {
      openDatabase(
        'Todo.db',
        version: 1,
        onCreate: (database, version) {
          //id integer
          //tittle string
          //detals string

          print('database created');
          database
              .execute(
                  'CREATE TABLE Tasks(id INTEGER PRIMARY KEY,title TEXT,detail TEXT,status TEXT )')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('Error when creating Table ${error.toString()}');
          });
        },
        onOpen: (database) {
          getfromdatabase(database);
          print('database opened');
        },
      ).then((value) {
        database = value;
        emit(TodoCreateDatabasestate());
      });
    }
  }

  void insertIntodatabase({
    required String title,
    required String detail,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO Tasks(title,detail,status) VALUES("$title","$detail","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(TodoInsertDatabasestate());
        getfromdatabase(database);
      }).catchError((error) {
        print('error when inserting ${error.toString()}');
      });
    });
  }

 void getfromdatabase(database) {
  
  emit(TodoGetDatabaseLoadingstate());
  Newtasks = [];
    Donetasks = [];
  database!.rawQuery('SELECT * FROM Tasks').then((value) {
    value.forEach((element) {
      if (element['status'] == 'new') {
        Newtasks.add(element);
      } else if (element['status'] == 'done'){
        Donetasks.add(element);
      }
    });
    print(Newtasks);
    print(Donetasks);

    emit(TodoGetDatabasestate());
  });
}


 
void updateData({
  required String status,
  required int id,
}) {
  database!.rawUpdate(
      'UPDATE Tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
    emit(TodoUpdateDatabasestate());
    emit(TodoGetDatabasestate());

  });
}

void deleteData({
  required int id,
}) {
  database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
    emit(TodoDeleteDatabasestate());
    emit(TodoGetDatabasestate());
        getfromdatabase(database);

  });
}

}
