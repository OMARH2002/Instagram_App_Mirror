
class LoginStates{}

class LogininitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSucessState extends LoginStates{}
class LoginErrorState  extends LoginStates{

  final  String errorMessage;
LoginErrorState(this.errorMessage);

}