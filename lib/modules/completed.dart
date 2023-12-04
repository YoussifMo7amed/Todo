
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class completed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
var tasks = TodoCubit.get(context).Donetasks.where((task) => task['status'] == 'done').toList();
    return BlocConsumer<TodoCubit, TodoStates>(
      builder: (context, state) {
        return tasksBuilder(
          tasks: tasks,
        );
      },
      listener: (context, state) {
        if(state is TodoGetDatabasestate||state is changeTodoNavBarstate)
        {
          TodoCubit.get(context).getfromdatabase(TodoCubit.get(context).database);
        }
      },
    );
  }
}
