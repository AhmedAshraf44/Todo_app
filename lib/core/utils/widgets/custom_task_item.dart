import 'package:flutter/material.dart';
import 'package:todo_app/feature/home/presentation/manger/home_cubit/home_cubit.dart';

class CustomTaskItem extends StatelessWidget {
  const CustomTaskItem({super.key, required this.tasks});
  final Map tasks;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(tasks['id'].toString()),
      onDismissed: (direction) {
        HomeCubit.get(context).deletfromDatabase(id: tasks['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text(tasks['time']),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tasks['tittle'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    tasks['date'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  HomeCubit.get(context)
                      .updateData(status: 'done', id: tasks['id']);
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  HomeCubit.get(context)
                      .updateData(status: 'archive', id: tasks['id']);
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  color: Colors.black45,
                )),
          ],
        ),
      ),
    );
  }
}
