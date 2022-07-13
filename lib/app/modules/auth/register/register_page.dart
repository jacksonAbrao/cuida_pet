import 'package:cuida_pet/app/core/ui/extentions/size_screen_extention.dart';
import 'package:cuida_pet/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuida_pet/app/core/ui/widgets/cuidapet_textform_field.dart';
import 'package:cuida_pet/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

part 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 162.w,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const _RegisterForm(),
          ],
        ),
      ),
    );
  }
}
