import 'package:TodoApp/shared/components/constants.dart';
import 'package:TodoApp/shared/cubit/cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/TodoPage.dart';

void main() {
    Bloc.observer = MyBlocObserver();

  runApp(BlocProvider(create: 
  (context) => TodoCubit()..createdatabase(),
  child:const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TOdopage(),
    );
  }
}