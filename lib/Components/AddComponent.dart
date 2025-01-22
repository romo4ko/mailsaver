
import 'package:flutter/material.dart';
import 'package:mailsaver/Models/Email.dart';

import '../Database/Database.dart';

class AddComponent extends StatefulWidget {
  final Function callback;

  const AddComponent({super.key, required this.callback});

  @override
  _AddComponentState createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {
  final _inputFormKey = GlobalKey<FormState>();
  final _outputFormKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _validate = true;
  List<Email> _emailsList = [];

  parseEmails() {
    var text = _controller.text;
    _emailsList.clear();

    final pattern = RegExp(r"[\w\.-]+@[\w\.-]+\.\w+");

    final matches = pattern.allMatches(text);

    _emailsList.clear();
    for (final match in matches) {
      var email = text.substring(match.start, match.end);
      _emailsList.add(
        Email(
            value: email,
        )
      );
    }

    setState(() {});
  }

  final SQLiteHelper database = SQLiteHelper();

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    database.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1
              )
            )
          ),
          child: Form(
            key: _inputFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    controller: _controller,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'Список электронных адресов',
                      errorText: _validate ? null : "Не найдено ни одного адреса",
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, width: 1),
                      ),
                    ),
                    onChanged: (text) {
                      parseEmails();
                    },
                  ),
                ),
                const SizedBox(height: 40),
                _emailsList.isNotEmpty ? ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _validate = _emailsList.isNotEmpty;
                    });
                    if (_emailsList.isNotEmpty) {
                      await database.batchInsert(_emailsList);
                      setState(() {
                        _controller.clear();
                        _emailsList.clear();
                      });
                      widget.callback();
                    }
                  },
                  child: Text('Добавить ${_emailsList.length}'),
                ) : const SizedBox(),
              ],
            ),
          ),
        ),
        Container(
          height: 300,
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _emailsList.length,
            itemBuilder: (context, index) {
              return Text(
                _emailsList[index].value,
              );
            }
          )
        ),
      ],
    );
  }
}