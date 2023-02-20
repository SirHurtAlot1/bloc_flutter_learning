// ignore_for_file: prefer_const_constructors

import 'package:bloc_simple_counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_bloc/bloc/user_bloc.dart';

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
    final counterBloc = CounterBloc();
    final userBloc = UserBloc();
    // To use block u need to wrap all widget that a going to use it in BlocProvider
    // It can use generic type
    //MultiblocProvider used when u need to use more than one block on a page
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          // u need to create method which are going to return instance of your bloc
          create: (context) => counterBloc,
          // in order to use states you need to wrap all widgets or one that are going
          // to be changed with BlocBuilder
          // see text widget
        ),
        BlocProvider<UserBloc>(
          create: (context) => userBloc,
        ),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => counterBloc.add(CounterIncEvent()),
                icon: const Icon(Icons.plus_one)),
            IconButton(
                onPressed: () => counterBloc.add(CounterDecEvent()),
                icon: const Icon(Icons.exposure_minus_1)),
            IconButton(
                onPressed: () =>
                    userBloc.add(UserGetUserEvent(counterBloc.state)),
                icon: const Icon(Icons.person)),
          ],
        ),
        body: SafeArea(
          child: Center(
            // u need to give blockbuilder your bloc and state (now it is int)
            child: Column(
              children: [
                BlocBuilder<CounterBloc, int>(
                  // and u need to specify your bloc
                  bloc: counterBloc,
                  builder: (context, state) {
                    return Text(state.toString(),
                        style: TextStyle(fontSize: 33));
                  },
                ),
                BlocBuilder<UserBloc, UserState>(
                  bloc: userBloc,
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (state is UserLoadingState)
                          CircularProgressIndicator(),
                        if (state is UserLoadedState)
                          ...state.users.map((e) => Text(e.name))
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
