abstract class AuthState {
  AuthState();
}

class AuthInitial extends AuthState {
  AuthInitial();
}



class LoginLoading extends AuthState {
  LoginLoading();
}

class LoginSuccess extends AuthState {
  LoginSuccess();
}

class LoginError extends AuthState {
  String errorText;
  LoginError({required this.errorText});
}



class SignUpLoading extends AuthState {
  SignUpLoading();
}

class SignUpSuccess extends AuthState {
  SignUpSuccess();
}

class SignUpError extends AuthState {
  String errorText;
  SignUpError({required this.errorText});
}



class SignOutLoading extends AuthState {
  SignOutLoading();
}

class SignOutSuccess extends AuthState {
  SignOutSuccess();
}

class SignOutError extends AuthState {
  String errorText;
  SignOutError({required this.errorText});
}













