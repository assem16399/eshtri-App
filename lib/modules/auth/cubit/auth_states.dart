abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthFailState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthKillTokenState extends AuthStates {}

class AuthUnableToKillTokenState extends AuthStates {}
