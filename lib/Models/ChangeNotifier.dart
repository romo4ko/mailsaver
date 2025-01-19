import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'Email.dart';

class EmailsManager extends ChangeNotifier {
  final List<Email> _emails = [];

  UnmodifiableListView<Email> get emails => UnmodifiableListView(_emails);

  void addEmail(Email email) {
    _emails.add(email);
    notifyListeners();
  }

  void addEmails(List<Email> emails) {
    _emails.addAll(emails);
    notifyListeners();
  }

  void removeEmail(Email email) {
    _emails.remove(email);
    notifyListeners();
  }
}