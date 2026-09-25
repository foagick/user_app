part of 'counter_bloc.dart';

@immutable
sealed class CounterState {}

final class CounterStatus extends CounterState {
  int count;
  CounterStatus({required this.count});
}
