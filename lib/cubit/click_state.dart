part of 'click_cubit.dart';

@immutable
abstract class ClickState {}

class ClickInitial extends ClickState {}

class ClickError extends ClickState {
  final String txt;

  ClickError(this.txt);
}

class Click extends ClickState {
  final int count;
  List<String> logs;
  Click(this.count, this.logs);
}
