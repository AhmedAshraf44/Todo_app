import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/home/presentation/manger/home_cubit/home_state.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../archived_tesks/presentation/view/archived_tasks_view.dart';
import '../../../../done_tasks/presentation/view/done_tasks_view.dart';
import '../../../../new_tasks/presentation/view/new_tasks_view.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> pages = const [
    NewTasksView(),
    DoneTasksView(),
    ArchivedTasksView(),
  ];

  List<String> appBar = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  var currentIndex = 0;
  IconData iconShowBottom = Icons.edit;
  bool isshowBottomSheet = false;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void changeBottomSheet({
    required IconData icon,
    required bool isShow,
  }) {
    iconShowBottom = icon;
    isshowBottomSheet = isShow;
    emit(ChangeBottomSheetState());
  }

  void createDatabase() {
    // Create a new database
    openDatabase(
      'todo.db',
      version: 1,
      // Create table in database
      onCreate: (database, version) {
        log("database created");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, tittle TEXT, date TEXT, time TEXT, status TEXT)')
            .then(
          (value) {
            log("table created");
          },
        ).catchError(
          (error) {
            log("Error When Creating Table ${error.toString()}");
          },
        );
      },
      onOpen: (database) {
        getFromDatabase(database);
        log("opened database");
      },
    ).then(
      (value) {
        database = value;
        emit(CreateDatabaseState());
      },
    );
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction(
      (txn) async {
        await txn
            .rawInsert(
                'INSERT INTO tasks(tittle, date, time,status) VALUES("$title", "$date", "$time","new")')
            .then((value) {
          emit(InsertDatabaseState());
          log('$value insert succusfuly');
          getFromDatabase(database);
        }).catchError(
          (error) {
            log('error in insert to database $error');
          },
        );
      },
    );
  }

  void getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then(
      (value) {
        value.forEach(
          (element) {
            if (element['status'] == 'new') {
              newTasks.add(element);
            } else if (element['status'] == 'done') {
              doneTasks.add(element);
            } else {
              archiveTasks.add(element);
            }
          },
        );
        emit(GetDatabaseState());
      },
    );
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then(
      (value) {
        getFromDatabase(database);
        emit(UpdateDatabaseState());
      },
    );
  }

  void deletfromDatabase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then(
      (value) {
        getFromDatabase(database);
        emit(DeleteDatabaseState());
      },
    );
  }
}
