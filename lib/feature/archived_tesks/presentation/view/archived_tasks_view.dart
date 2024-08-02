import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/widgets/custom_conditional_builder.dart';

import '../../../home/presentation/manger/home_cubit/home_cubit.dart';
import '../../../home/presentation/manger/home_cubit/home_state.dart';

class ArchivedTasksView extends StatelessWidget {
  const ArchivedTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = HomeCubit.get(context).archiveTasks;
          return CustomConditionalBuilder(tasks: tasks);
        });
  }
}
