import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterStatus(count: 100)) {

    on<IncrementButtonPressed>((event, emit) {
      if (state is CounterStatus) {
        int current = (state as CounterStatus).count;
        emit(CounterStatus(count: current + 1));
      }
    });

    on<DecrementButtonPressed>((event, emit) {
      if (state is CounterStatus) {
        int current = (state as CounterStatus).count;
        emit(CounterStatus(count: current - 1));
      }
    });
  }
}
