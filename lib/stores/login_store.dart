import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  Future login()async{
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    loggedIn = true;
  }


  @observable
  bool visualisarSenha = true;
  @action
  setVisualisarSenha() => visualisarSenha = !visualisarSenha;
  
  
  @observable
  String email = "";
  @action
  setEmail(String value) => email = value;
  
  @observable
  String senha = "";
  @action
  setSenha(String value) => senha = value;

  @computed
  bool get isEmailValid => email.length >= 6;

  @computed
  bool get isSenhaValid => senha.length >= 6;

  @computed
  Function get loginPressed =>
  (isEmailValid && isSenhaValid && !loading) ? login : null;

  @action
  void logout(){
    loggedIn = false;
  }
}