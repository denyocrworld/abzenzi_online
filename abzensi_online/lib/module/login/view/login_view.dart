import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/shared/app/widget/logo/logo.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Positioned(
            left: -MediaQuery.of(context).size.width * 0.3,
            top: -MediaQuery.of(context).size.width * 0.3,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: MediaQuery.of(context).size.width * 0.36,
            )
                .animate()
                .move(
                  begin: Offset(-100, -100),
                  duration: 600.ms,
                )
                .fadeIn(
                  duration: 800.ms,
                ),
          ),
          Positioned(
            right: -MediaQuery.of(context).size.width * 0.3,
            bottom: -MediaQuery.of(context).size.width * 0.3,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: MediaQuery.of(context).size.width * 0.36,
            )
                .animate()
                .move(
                  begin: Offset(100, 100),
                  duration: 600.ms,
                )
                .fadeIn(
                  duration: 800.ms,
                ),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 24,
                          offset: Offset(0, 11),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        QLogo(
                          width: 120.0,
                          height: 120.0,
                        ),
                        Text(
                          "AttendMe",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            .animate()
                            .scale(
                              duration: 600.ms,
                            )
                            .moveY(
                              begin: 100,
                              duration: 600.ms,
                            )
                            .fadeIn(
                              duration: 800.ms,
                            ),
                        SizedBox(
                          height: 40.0,
                        ),
                        QTextField(
                          label: "Email",
                          validator: Validator.email,
                          suffixIcon: Icons.email,
                          value: controller.email,
                          onChanged: (value) {
                            controller.email = value;
                          },
                        )
                            .animate()
                            .move(
                              duration: 600.ms,
                            )
                            .fadeIn(
                              duration: 800.ms,
                            ),
                        QTextField(
                          label: "Password",
                          obscure: true,
                          validator: Validator.required,
                          suffixIcon: Icons.password,
                          value: controller.password,
                          onChanged: (value) {
                            controller.password = value;
                          },
                        )
                            .animate()
                            .move(
                              duration: 600.ms,
                            )
                            .fadeIn(
                              duration: 800.ms,
                            ),
                        QButton(
                          label: "Login",
                          onPressed: () async => controller.doLogin(),
                        )
                            .animate()
                            .scale(
                              duration: 600.ms,
                            )
                            .fadeIn(
                              duration: 800.ms,
                            ),
                      ],
                    ),
                  )
                      .animate()
                      .moveY(
                        begin: -100,
                        duration: 600.ms,
                      )
                      .fadeIn(
                        duration: 800.ms,
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
