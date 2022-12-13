import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial()) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      mytimer++;

      if (mytimer >= 5) {
        plus(updateCount: false);
      }
      emit(state);
    });
  }
  int count = 0;
  int mytimer = 0;
  bool type = true;
  List<String> logs = [];

  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      mytimer++;

      if (mytimer >= 5) {
        plus(updateCount: false);
      }
      emit(state);
    });
  }

  void plus({bool updateCount = true}) {
    count += type ? 1 : 2;

    logs.add("+ ${type ? 1 : 2}");
    if (updateCount == true) {
      mytimer = 0;
    }
    emit(Click(count, logs));
  }

  void minus() {
    count -= type ? 1 : 2;
    logs.add("- ${type ? 1 : 2}");
    mytimer = 0;
    emit(
      Click(count, logs),
    );
  }

  void changeTheme() {
    type = !type;
    logs.add("use theme ${type ? 'white' : 'black'}");
    mytimer = 0;
    emit(
      Click(count, logs),
    );
  }

  void delete() async {
    mytimer = 0;
    logs.clear();
    count = 0;
    emit(
      Click(count, logs),
    );
  }
}
