import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mox_tutorial/screens/list_screen.dart';
import 'package:mox_tutorial/stores/login_store.dart';
import 'package:mox_tutorial/widgets/custom_icon_button.dart';
import 'package:mox_tutorial/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    autorun((_){
      if(loginStore.loggedIn){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_)=>ListScreen())
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(32),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Observer(builder: (_) {
                    return CustomTextField(
                      hint: "E-mail",
                      prefix: Icon(Icons.account_circle),
                      textInputType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enabled: !loginStore.loading,
                    );
                  }),
                  SizedBox(
                    height: 16,
                  ),
                  Observer(builder: (_) {
                    return CustomTextField(
                      hint: "Senha",
                      prefix: Icon(Icons.lock),
                      suffix: CustomIconButton(
                        iconData: loginStore.visualisarSenha
                            ? Icons.visibility
                            : Icons.visibility_off,
                        radius: 32,
                        onTap: loginStore.setVisualisarSenha,
                      ),
                      onChanged: loginStore.setSenha,
                      enabled: !loginStore.loading,
                      obscure: loginStore.visualisarSenha,
                    );
                  }),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: Observer(builder: (_) {
                      return RaisedButton(
                        onPressed: loginStore.loginPressed,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: loginStore.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text("Login"),
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
