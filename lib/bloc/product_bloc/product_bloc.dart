import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Product p
  ProductBloc() : super(ProductInitial()) {
    on<ProductAddedEvent>((event, emit) {
      // Handle product added event
    });
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
