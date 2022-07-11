part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CuidapetTextFormField(label: 'E-mail'),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            label: 'Senha',
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            label: 'Confirme a senha',
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetDefaultButton(
            onPressed: () {},
            label: 'Cadastrar',
          )
        ],
      ),
    ));
  }
}
