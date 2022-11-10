import 'package:flutter/material.dart';

import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 193, 139),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Todo List'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, "profile"),
              icon: Icon(Icons.person))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 81, 193, 139),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true, //1
            context: context,
            builder: (context) {
              return ModelTextfield();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
