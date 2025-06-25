import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CountScreen extends StatelessWidget
{
  @override
Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => Countercubit(),
      child: BlocConsumer<Countercubit, CounterStates>(
        listener:(context, state) {} ,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Counter'),
              ),
              body: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: (){
                          Countercubit.get(context).minus();
                          print('${Countercubit.get(context).counter}');
                        },
                        child: Text('Minus'),
                      ),
                      Text('${Countercubit.get(context).counter}'),
                      TextButton(
                        onPressed: () {
                          Countercubit.get(context).plus();
                          print('${Countercubit
                              .get(context)
                              .counter}');
                        },
                        child: Text('Plus'),
                      ),
                    ]
                ),
              )
          );
        }
      ),
    );
  }
}