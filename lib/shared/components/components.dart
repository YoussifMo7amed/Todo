import 'package:TodoApp/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modules/edit.dart';

Widget dfaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        void Function(String)? onChange,
        void Function(String)? onsubmit,
        String? Function(String?)? validator,
        required String label,
        required IconData? prefix,
        bool ispassword = false,
        IconData? sufix,
        void Function()? ontap,
        void Function()? sufixFunction}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      onChanged: onChange,
      onFieldSubmitted: onsubmit,
      validator: validator,
      onTap: ontap,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: sufix != null
              ? IconButton(onPressed: sufixFunction, icon: Icon(sufix))
              : null,
          border: const OutlineInputBorder()),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = const Color(0xff9395D3),
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function() function,
  required String text,
}) =>
    Container(
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(20.0)),
        width: width,
        height: 50.0,
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.black,
            ),
          ),
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
Widget buildTaskItem(Map model, context) {
  return Container(
    margin: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    width: double.infinity,
    height: 70,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${model['title']}",
              style: const TextStyle(
                  fontSize: 17.0,
                  color: Color(0xffB3B7EE),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "${model['detail']}",
              style: TextStyle(fontSize: 12.0),
            )
          ],
        ),
        const SizedBox(
          width: 120.0,
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Edit(),
                  ));
            },
            icon: const Icon(
              Icons.edit,
              color: Color(0xff9395D3),
            )),
        IconButton(
          onPressed: () {
            // Delete the task
            TodoCubit.get(context).deleteData(id: model['id']);
          },
          icon: const Icon(
            Icons.delete,
            color: Color(0xff9395D3),
          ),
        ),
        IconButton(
          onPressed: () {
            // Update the task status
           TodoCubit.get(context).updateData(status: 'done', id: model['id']);
          },
          icon: const Icon(
            Icons.cloud_done_rounded,
            color: Color(0xff9395D3),
          ),
        ),
      ],
    ),
  );
}
