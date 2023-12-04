// ignore_for_file: file_names, unused_local_variable

import 'package:back/modules/add.dart';
import 'package:back/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/states.dart';

class TOdopage extends StatelessWidget {
  const TOdopage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          return Scaffold(
              backgroundColor: const Color(0xffD6D7EF),
              appBar: AppBar(
                backgroundColor: const Color(0xff9395D3),
                title: const Text(
                  "TODO APP",
                  style: TextStyle(fontSize: 24.0),
                ),
                elevation: 0.0,
                actions: const [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 32.0,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              body: ConditionalBuilder(
            condition: state is! TodoGetDatabaseLoadingstate,
            builder: (context) => cubit.screens[cubit.currentIndex],
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Add(),
                      ));
                },
                child: Icon(Icons.add),
                backgroundColor: Color(0xff9395D3),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (value) {
                    cubit.changeIndex(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list_outlined), label: "ALL"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done), label: "Completed"),
                  ]));
        });
  }
}
