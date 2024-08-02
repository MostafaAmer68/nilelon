part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String successMSG;

  const LoginSuccess(this.successMSG);
}

class VerificationSuccess extends AuthState {}

class VerificationCodeSent extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);
}

class CustomerRegisterLoading extends AuthState {}

class CustomerRegisterSuccess extends AuthState {
  final String successMessage;

  const CustomerRegisterSuccess(this.successMessage);
}

class CustomerRegisterFailure extends AuthState {
  final String errorMessage;

  const CustomerRegisterFailure(this.errorMessage);
}

class StoreRegisterLoading extends AuthState {}

class StoreRegisterSuccess extends AuthState {
  final String successMessage;

  const StoreRegisterSuccess(this.successMessage);
}

class StoreRegisterFailure extends AuthState {
  final String errorMessage;

  const StoreRegisterFailure(this.errorMessage);
}

class StoreGoogleRegisterLoading extends AuthState {}

class StoreGoogleRegisterSuccess extends AuthState {
  final String successMessage;

  const StoreGoogleRegisterSuccess(this.successMessage);
}

class StoreGoogleRegisterFailure extends AuthState {
  final String errorMessage;

  const StoreGoogleRegisterFailure(this.errorMessage);
}

// class VerifyUserLoading extends AuthState {}

// class VerifyUserSuccess extends AuthState {}

// class VerifyUserFailure extends AuthState {
//   final String errorMessage;

//   const VerifyUserFailure(this.errorMessage);
// }

// class ForgetPasswordLoading extends AuthState {}

// class ForgetPasswordSuccess extends AuthState {}

// class ForgetPasswordFailure extends AuthState {
//   final String errorMessage;

//   const ForgetPasswordFailure(this.errorMessage);
// }

// class ResetPasswordLoading extends AuthState {}

// class ResetPasswordSuccess extends AuthState {}

// class ResetPasswordFailure extends AuthState {
//   final String errorMessage;

//   const ResetPasswordFailure(this.errorMessage);
// }

// class DeleteAccountLoading extends AuthState {}

// class DeleteAccountSuccess extends AuthState {}

// class DeleteAccountFailure extends AuthState {
//   final String errorMessage;

//   const DeleteAccountFailure(this.errorMessage);
// }

// class ChangeAccountNameLoading extends AuthState {}

// class ChangeAccountNameSuccess extends AuthState {}

// class ChangeAccountNameFailure extends AuthState {
//   final String errorMessage;

//   const ChangeAccountNameFailure(this.errorMessage);
// }
