import 'package:flutter/material.dart';

import 'Database/Database.dart';
import 'Models/Email.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    helper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: TextButton(
            onPressed: () async {
              await helper.batchInsert();
              setState(() {});
            },
            child: const Text("ADD"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {});
              },
              child: const Text("DEL"),
            ),
          ]),
      body: FutureBuilder<List<Email>>(
        future: helper.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          } else {
            final emails = snapshot.data!;

            return ListView.builder(
              itemCount: emails.length,
              itemBuilder: (context, index) {
                final email = emails[index];

                return _card(email, context);
              },
            );
          }
        },
      ),
    );
  }
}

Widget _card(Email email, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID: ${email.id}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Value: ${email.value}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "categoryId: ${email.categoryId}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "createdAt: ${email.createdAt}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
