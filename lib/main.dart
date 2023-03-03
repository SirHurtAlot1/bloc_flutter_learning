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
    // To use block u need to wrap all widget that a going to use it in BlocProvider
    // It can use generic type
    //MultiblocProvider used when u need to use more than one block on a page
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          // u need to create method which are going to return instance of your bloc
          create: (context) => CounterBloc(),
          // in order to use states you need to wrap all widgets or one that are going
          // to be changed with BlocBuilder
          // see text widget
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: Builder(builder: ((context) {
        final counterBloc = BlocProvider.of<CounterBloc>(context);
        final userBloc = BlocProvider.of<UserBloc>(context);
        return Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    counterBloc.add(CounterIncEvent());
                  },
                  icon: const Icon(Icons.plus_one)),
              IconButton(
                  onPressed: () {
                    counterBloc.add(CounterDecEvent());
                  },
                  icon: const Icon(Icons.exposure_minus_1)),
              IconButton(
                  onPressed: () {
                    userBloc.add(
                        UserGetUserEvent(context.read<CounterBloc>().state));
                  },
                  icon: const Icon(Icons.person)),
              IconButton(
                  onPressed: () {
                    userBloc.add(
                        UserGetUserJobEvent(context.read<CounterBloc>().state));
                  },
                  icon: const Icon(Icons.work)),
            ],
          ),
          body: SafeArea(
            child: Center(
              // u need to give blockbuilder your bloc and state (now it is int)
              child: Column(
                children: [
                  BlocBuilder<CounterBloc, int>(
                    // and u need to specify your bloc
                    // bloc: counterBloc,
                    builder: (context, state) {
                      final users = context.select(
                        (UserBloc bloc) => bloc.state.users,
                      );
                      return Column(
                        children: [
                          Text(state.toString(),
                              style: TextStyle(fontSize: 33)),
                          if (users.isNotEmpty)
                            ...users.map((e) => Text(e.name)),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    //bloc: userBloc,
                    builder: (context, state) {
                      final jobs = state.jobs;
                      return Column(
                        children: [
                          if (state.isLoading) CircularProgressIndicator(),
                          if (jobs.isNotEmpty) ...jobs.map((e) => Text(e.name))
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}
