// ignore_for_file: prefer_const_constructors

import 'package:bloc_simple_counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = CounterBloc();
    // To use block u need to wrap all widget that a going to use it in BlocProvider
    // It can use generic type
    return BlocProvider<CounterBloc>(
      // u need to create method which are going to return instance of your bloc
      create: (context) => bloc,
      // in order to use states you need to wrap all widgets or one that are going
      // to be changed with BlocBuilder
      // see text widget
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => bloc.add(CounterIncEvent()),
                icon: const Icon(Icons.plus_one)),
            IconButton(
                onPressed: () => bloc.add(CounterDecEvent()),
                icon: const Icon(Icons.exposure_minus_1)),
          ],
        ),
        body: Center(
          // u need to give blockbuilder your bloc and state (now it is int)
          child: BlocBuilder<CounterBloc, int>(
            // and u need to specify your bloc
            bloc: bloc,
            builder: (context, state) {
              return Text(state.toString(), style: TextStyle(fontSize: 33));
            },
          ),
        ),
      ),
    );
  }
}
