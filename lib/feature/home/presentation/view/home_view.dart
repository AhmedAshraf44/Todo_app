import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/feature/home/presentation/manger/home_cubit/home_cubit.dart';
import 'package:todo_app/feature/home/presentation/manger/home_cubit/home_state.dart';
import 'package:todo_app/feature/home/presentation/view/widgets/custom_text_form_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static var scaffoldkey = GlobalKey<ScaffoldState>();
  static var formkey = GlobalKey<FormState>();

  static TextEditingController tittleController = TextEditingController();
  static TextEditingController dateController = TextEditingController();
  static TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..createDatabase(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is InsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                cubit.appBar[cubit.currentIndex],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              shape: const OvalBorder(),
              onPressed: () {
                if (cubit.isshowBottomSheet) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: tittleController.text,
                        date: dateController.text,
                        time: timeController.text);
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet(
                        //elevation: 25,
                        (context) {
                          return Container(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextFormField(
                                        onTap: () {},
                                        controller: tittleController,
                                        keyboardType: TextInputType.text,
                                        prefixIcon: const Icon(Icons.title),
                                        labelText: 'Task Title',
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Title must be not empty';
                                          } else {
                                            return null;
                                          }
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextFormField(
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then(
                                            (value) {
                                              timeController.text = value!
                                                  .format(context)
                                                  .toString();
                                            },
                                          );
                                        },
                                        controller: timeController,
                                        keyboardType: TextInputType.number,
                                        prefixIcon: const Icon(
                                            Icons.watch_later_outlined),
                                        labelText: 'Task Time',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Time must be not empty';
                                          } else {
                                            return null;
                                          }
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextFormField(
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2025))
                                              .then(
                                            (value) {
                                              dateController.text =
                                                  DateFormat.yMMMEd()
                                                      .format(value!);

                                              //  print(
                                              // 'value : ${dateController.text}');
                                            },
                                          );
                                        },
                                        controller: dateController,
                                        keyboardType: TextInputType.datetime,
                                        prefixIcon:
                                            const Icon(Icons.calendar_today),
                                        labelText: 'Task Date',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'date must be not empty';
                                          } else {
                                            return null;
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      .closed
                      .then((value) {
                        cubit.changeBottomSheet(
                            icon: Icons.edit, isShow: false);
                      });
                  cubit.changeBottomSheet(icon: Icons.add, isShow: true);
                }
              },
              child: Icon(
                cubit.iconShowBottom,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Task'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'archived'),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! GetDatabaseLoadingState,
              builder: (context) => cubit.pages[cubit.currentIndex],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
