import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/states.dart';


class Countercubit extends Cubit<CounterStates>
{
  Countercubit() : super(CounterInitailState());
  // to call object from this class in all app   we use BlocProvider.of(context) like we create an object in main.dart
static Countercubit get(context) => BlocProvider.of(context);

int counter = 1;

void minus()
{
  counter--;
  // to emit => send a state like set state in flutter
  emit(CounterMinusState(counter));
}
void plus()
{
  counter++;
  emit(CounterPlusState(counter));
}
}
