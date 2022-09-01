import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class User {
  final String title;
  final String age;

  User({
    required this.title,
    required this.age,
  });
}

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  final titleController = TextEditingController();
  final ageController = TextEditingController();

  final List<User> usersList = [];

  void addUser() {
    var title = titleController.text;
    var age = ageController.text;

    final check = usersList.every((user) => user.title != title);

    if (title.isNotEmpty && age.isNotEmpty && check) {
      usersList.add(User(title: title, age: age));

      titleController.text = '';
      ageController.text = '';

      setState(() {});
    } else {
      final snackBar = SnackBar(
        content: const Text('Такий фільм вже існує або місце пусте'),
        action: SnackBarAction(
          label: 'Фільми',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Title',
                  fillColor: Colors.white10,
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Year',
                  fillColor: Colors.white10,
                  border: OutlineInputBorder()),
            ),
          ),
          FloatingActionButton(
            onPressed: addUser,
            child: Text('Add'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: usersList
                  .map(
                    (e) => Card(
                      child: ListTile(
                        title: Text('Title : ${e.title} Year : ${e.age}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
