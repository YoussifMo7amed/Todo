// ignore_for_file: use_key_in_widget_constructors

import 'package:back/shared/components/components.dart';
import 'package:back/shared/cubit/cubit.dart';
import 'package:back/shared/cubit/states.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Edit extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: BlocConsumer<TodoCubit, TodoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            TodoCubit cubit = TodoCubit.get(context);

            return Scaffold(
              backgroundColor: Color(0xffFFFFFF),
              appBar: AppBar(
                backgroundColor: const Color(0xff9395D3),
                title: const Text(
                  "Edit Task",
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
                            border: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid)),
                                          
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
                            border: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid)),
                                          
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
                      defaultButton(function: (){
                        if(formkey.currentState!.validate())
                        {
                          
                        }
                      }, text: "EDIT")
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
