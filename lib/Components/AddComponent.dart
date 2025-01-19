
import 'package:flutter/material.dart';

import '../Database/Database.dart';

class AddComponent extends StatefulWidget {
  const AddComponent({Key? key}) : super(key: key);

  @override
  _AddComponentState createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {
  final _inputFormKey = GlobalKey<FormState>();
  final _outputFormKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                        errorText: _validate ? null : "Заполните это поле",
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _validate = _controller.text.isNotEmpty;
                      });
                      if (_validate && _inputFormKey.currentState!.validate()) {
                        // await SQLiteHelper.insert());
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _outputFormKey,
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
                        errorText: _validate ? null : "Заполните это поле",
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _validate = _controller.text.isNotEmpty;
                      });
                      if (_validate && _outputFormKey.currentState!.validate()) {
                        // await SQLiteHelper.insert());
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}