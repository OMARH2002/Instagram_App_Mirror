
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/LOGIC/SIGNUP/state.dart';


class SignUpCubit extends Cubit<SignUpStates>{
  FirebaseAuth firebaseAuth;
  SignUpCubit(this.firebaseAuth):super(SignUpInitialState());

  Future SignUp(String email,String password)async{
    emit(SignUpLoadingState());
try{
  await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
emit(SignupSuccessState());

}
    catch(e){
emit(SignUpErrorState(e.toString()));
    }
  }
}