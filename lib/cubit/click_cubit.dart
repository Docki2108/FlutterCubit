import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial()) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      secondCount++;

      if (secondCount >= 5) {
        increment(updateCount: false);
      }
      emit(state);
    });
  }
  int count = 0;
  int secondCount = 0;
  bool type = true;
  List<String> logs = [];

  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      secondCount++;

      if (secondCount >= 5) {
        increment(updateCount: false);
      }
      emit(state);
    });
  }

  void saveShared() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList('logs', logs);
    prefs.setInt('count', count);
    prefs.setBool('type_theme', type);
  }

  void increment({bool updateCount = true}) {
    count += type ? 1 : 2;

    logs.add("+ ${type ? 1 : 2}");
    saveShared();
    if (updateCount == true) {
      secondCount = 0;
    }
    emit(Click(count, logs));
  }

  void decrement() {
    count -= type ? 1 : 2;

    logs.add("- ${type ? 1 : 2}");

    saveShared();
    secondCount = 0;
    emit(
      Click(count, logs),
    );
  }

  void changeTheme() {
    type = !type;
    logs.add("use theme ${type ? 'white' : 'black'}");

    saveShared();
    secondCount = 0;
    emit(
      Click(count, logs),
    );
  }

  void deleteAllDataInSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('logs');
    prefs.remove('count');
    prefs.remove('type_theme');
    secondCount = 0;
    logs.clear();
    count = 0;
    emit(
      Click(count, logs),
    );
  }
}
