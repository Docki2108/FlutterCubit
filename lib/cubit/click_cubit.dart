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
        plus(updateCount: false);
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
        plus(updateCount: false);
      }
      emit(state);
    });
  }

  void plus({bool updateCount = true}) {
    count += type ? 1 : 2;

    logs.add("+ ${type ? 1 : 2}");
    if (updateCount == true) {
      secondCount = 0;
    }
    emit(Click(count, logs));
  }

  void minus() {
    count -= type ? 1 : 2;
    logs.add("- ${type ? 1 : 2}");
    secondCount = 0;
    emit(
      Click(count, logs),
    );
  }

  void changeTheme() {
    type = !type;
    logs.add("use theme ${type ? 'white' : 'black'}");
    secondCount = 0;
    emit(
      Click(count, logs),
    );
  }

  void delete() async {
    secondCount = 0;
    logs.clear();
    count = 0;
    emit(
      Click(count, logs),
    );
  }
}
