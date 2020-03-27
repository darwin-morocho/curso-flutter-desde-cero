import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool fetching;
  final int intents;

  LoginState({this.fetching = false, this.intents = 0});

  @override
  List<Object> get props => [fetching, intents];

  LoginState copyWith({bool fetching, int intents}) {
    return LoginState(
        fetching: fetching ?? this.fetching, intents: intents ?? this.intents);
  }
}
