// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:TodoApp/shared/components/components.dart';
import 'package:TodoApp/shared/cubit/cubit.dart';
import 'package:TodoApp/shared/cubit/states.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Add extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          // Clear text controllers when the Add screen is disposed
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cubit.titlecontroller.clear();
            cubit.detailscontroller.clear();
          });
          return Scaffold(
            backgroundColor: Color(0xffFFFFFF),
            appBar: AppBar(
              backgroundColor: const Color(0xff9395D3),
              title: const Text(
                "Add Task",
                style: TextStyle(fontSize: 24.0),
              ),
              elevation: 0.0,
            ),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Title"),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid)),
                        ),
                        controller: cubit.titlecontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title must not be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Detail"),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid)),
                        ),
                        controller: cubit.detailscontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "details must not be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            cubit.insertIntodatabase(
                                title: cubit.titlecontroller.text,
                                detail: cubit.detailscontroller.text);
                          }
                        },
                        text: "ADD")
                  ],
                ),
              ),
            ),
          );
        });
  }
}
