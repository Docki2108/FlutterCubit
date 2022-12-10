// ignore_for_file: depend_on_referenced_packages, camel_case_types

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class theme_cubit extends Cubit<ThemeMode> {
  theme_cubit() : super(ThemeMode.system);

  bool them = true;

  void changeTheme() {
    them = !them;
    emit(them ? ThemeMode.light : ThemeMode.dark);
  }
}
