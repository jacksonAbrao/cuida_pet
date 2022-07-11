import 'package:cuida_pet/app/core/ui/icons/cuida_pet_icons.dart';
import 'package:cuida_pet/app/core/ui/widgets/cuidapet_textform_field.dart';
import 'package:cuida_pet/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final testeEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CuidapetTextFormField(
                label: 'Login',
                obscureText: true,
                controller: testeEC,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Valor obrigatório';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  formKey.currentState?.validate();
                  print(testeEC.text);
                },
                child: const Text('Validar'),
              ),
              RoundedButtonWithIcon(
                onTap: () {},
                width: 200,
                color: Colors.blue,
                icon: CuidaPetIcons.facebook,
                label: 'Facebook',
              ),
              RoundedButtonWithIcon(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicou no Google')),
                  );
                },
                width: 200,
                color: Colors.red,
                icon: CuidaPetIcons.google,
                label: 'Google',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
