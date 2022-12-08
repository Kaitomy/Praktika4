import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class CubitCounter extends Cubit<HomeState> {
  CubitCounter() : super(const HomeState(0));

  void add(int count) =>
   emit(HomeState(state.counter + count));
  void sub(int count) =>
   emit(HomeState(state.counter - count));
}


@immutable
class HomeState {
  final int counter;

  const HomeState(this.counter); 
}