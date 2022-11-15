import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/model/model.dart';
import 'package:front_end_flutter/utils/constant.dart';
import 'package:front_end_flutter/utils/network/network_util.dart';
import 'package:front_end_flutter/utils/route/routeName.dart';

class Login extends BaseWidget {
  const Login({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _LoginState();
  }
}

class _LoginState extends BaseWidgetState<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: Center(
          child: registerWiget(
              h: 800,
              w: 300,
              child: Column(
                children: [
                  c(
                    h: yy(250),
                    // color: Colors.red,
                    alig: Alignment.center,
                    child: txtw("Login", size: xx(24)),
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
                                    w: xx(250),
                                    h: yy(140),
                                    alig: Alignment.center,
                                    child: myForm(
                                      editingController: passController,
                                      hintText: "Mot de passe",
                                      obscureText: true,
                                    ),
                                  ),
                                ],
                              )))),
                  c(
                      h: yy(120),
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: registerBttn(
                              onPointerDown: (onPointerDown) {
                                toPage(routesName: RoutesName.SIGNUP_PAGE);
                              },
                              txt: "SIGN UP",
                              color: const Color.fromRGBO(48, 59, 83, 1),
                              txtColor: bc(),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: registerBttn(
                                  onPointerDown: (onPointerDown) async {
                                    // if (formKey.currentState!.validate()) {
                                    postMap(
                                      "login",
                                      {
                                        "email": emailController.text,
                                        "password": passController.text
                                      },
                                      (callback) {
                                        if (callback['status'] == 1) {
                                          User _user =
                                              User.fromJson(callback['data']);
                                          user = _user;
                                          setValue(
                                                  key: userKey,
                                                  value: jsonEncode(user))
                                              .then((value) {
                                            jumpCleanToPage(
                                                routesName:
                                                    RoutesName.HOME_PAGE);
                                          });
                                        } else {
                                          showToast(callback['status_message']);
                                        }
                                      },
                                    );
                                    // }
                                  },
                                  txt: "LOG IN",
                                  color:
                                      const Color.fromRGBO(232, 233, 236, 1))),
                        ],
                      )),
                ],
              ))),
    );
  }
}
