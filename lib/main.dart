import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/controller/cubit/task_cubit.dart';
import 'package:to_do/models/task_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: BlocProvider(
        create: (context) => TaskCubit(),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Add task'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(controller.text.isEmpty) return;
                    context.read<TaskCubit>().addTask(controller.text);
                    controller.clear();
                  },
                  child: Text('Add New Task'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tasksList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(state.tasksList[index].title),
                        leading: Checkbox(
                          value:state.tasksList[index].isCompleted,
                          onChanged:(value){}),

                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
