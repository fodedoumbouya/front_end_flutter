import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/utils/network/network_util.dart';
import 'package:front_end_flutter/utils/route/routeName.dart';

class SignUp extends BaseWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _SignUpState();
  }
}

class _SignUpState extends BaseWidgetState<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();

    repeatPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: registerWiget(
            h: 1000,
            w: 300,
            child: Column(
              children: [
                c(
                  h: yy(250),
                  // color: Colors.red,
                  alig: Alignment.center,
                  child: txtw("Register", size: xx(24)),
                ),
                Expanded(
                    child: c(
                        // color: Colors.blue,
                        child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                c(
                                  color: bc(),
                                  w: xx(250),
                                  h: yy(140),
                                  child: myForm(
                                    editingController: emailController,
                                    hintText: "E-MAIL",
                                  ),
                                ),
                                c(
                                  color: bc(),
                                  w: xx(250),
                                  h: yy(140),
                                  child: myForm(
                                    editingController: nameController,
                                    hintText: "Name",
                                  ),
                                ),
                                c(
                                  w: xx(250),
                                  h: yy(140),
                                  alig: Alignment.center,
                                  child: myForm(
                                    editingController: passController,
                                    hintText: "Mot de passe",
                                    obscureText: true,
                                  ),
                                ),
                                c(
                                  w: xx(250),
                                  h: yy(140),
                                  alig: Alignment.center,
                                  child: myForm(
                                    editingController: repeatPassController,
                                    hintText: "Confirmer Mot de passe",
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            )))),
                c(
                  h: yy(120),
                  child: registerBttn(
                    onPointerDown: (onPointerDown) {
                      if (formKey.currentState!.validate()) {
                        if (passController.text != repeatPassController.text) {
                          showToast("Les deux mot de passe sont differents");
                          passController.clear();
                          repeatPassController.clear();
                          rebuildState();
                        } else {
                          var body = {
                            "name": nameController.text,
                            "email": emailController.text,
                            "password": passController.text,
                            "confirm_password": repeatPassController.text
                          };
                          // {
                          //   "name": nameController.text,
                          //   "email": emailController.text,
                          //   "password": passController.text,
                          // };
                          postMap("register", body, (callback) {
                            showToast(callback["status_message"]);
                            if (callback['status'] == 1) {
                              jumpToPage(routesName: RoutesName.LOGIN_PAGE);
                            }
                          });
                        }
                      }
                    },
                    txt: "REGISTER",
                    color: const Color.fromRGBO(48, 59, 83, 1),
                    txtColor: bc(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
