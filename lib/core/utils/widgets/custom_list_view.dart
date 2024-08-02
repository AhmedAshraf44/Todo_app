import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/widgets/custom_divider.dart';

import 'custom_task_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.tasks,
  });
  final List<Map<dynamic, dynamic>> tasks;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => CustomTaskItem(tasks: tasks[index]),
        separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsetsDirectional.only(
                start: 20,
              ),
              child: CustomDivider(),
            ),
        itemCount: tasks.length);
  }
}
