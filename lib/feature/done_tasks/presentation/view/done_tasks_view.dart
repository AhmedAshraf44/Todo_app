import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/home/presentation/manger/home_cubit/home_state.dart';

import '../../../../core/utils/widgets/custom_conditional_builder.dart';
import '../../../home/presentation/manger/home_cubit/home_cubit.dart';

class DoneTasksView extends StatelessWidget {
  const DoneTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = HomeCubit.get(context).doneTasks;
          return CustomConditionalBuilder(tasks: tasks);
        });
  }
}
