import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/widgets/custom_list_view.dart';

class CustomConditionalBuilder extends StatelessWidget {
  const CustomConditionalBuilder({super.key, required this.tasks});
  final List<Map> tasks;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => CustomListView(
        tasks: tasks,
      ),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 40,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
