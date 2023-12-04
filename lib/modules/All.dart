import 'package:back/shared/components/components.dart';
import 'package:back/shared/cubit/cubit.dart';
import 'package:back/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ALL extends StatelessWidget {
  const ALL({super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = TodoCubit.get(context).Newtasks;
    return BlocConsumer<TodoCubit, TodoStates>(
      builder: (context, state) {
        return tasksBuilder(
          tasks: tasks,
        );
      },
      listener: (context, state) {
      if(state is TodoGetDatabasestate)
        {
                    TodoCubit.get(context).getfromdatabase(TodoCubit.get(context).database);

        }
       
      },
    );
  }
}
