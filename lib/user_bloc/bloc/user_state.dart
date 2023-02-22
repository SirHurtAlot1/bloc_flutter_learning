part of 'user_bloc.dart';

class UserState {
  final List<User> users;
  final List<Job> jobs;
  final bool isLoading;

  UserState(
      {this.users = const [], this.jobs = const [], this.isLoading = false});

// copyWith is used for loading diffrenet data to the same object
// u just make a copy of a previous object
  UserState copyWith({
    List<User>? users,
    List<Job>? jobs,
    bool isLoading = false,
  }) {
    return UserState(
        users: users ?? this.users,
        jobs: jobs ?? this.jobs,
        isLoading: isLoading);
  }
}

class User {
  final String name;
  final String id;

  User({required this.name, required this.id});
}

class Job {
  final String name;
  final String id;

  Job({required this.name, required this.id});
}
