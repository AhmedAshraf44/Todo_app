import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc_observer.dart';
import 'package:todo_app/feature/home/presentation/view/home_view.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
