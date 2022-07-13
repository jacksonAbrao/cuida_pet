part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState
    extends ModularState<_RegisterForm, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CuidapetTextFormField(
                label: 'E-mail',
                controller: _loginEC,
                validator: Validatorless.multiple([
                  Validatorless.required('E-mail obrigatório'),
                  Validatorless.email('E-mail inválido'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CuidapetTextFormField(
                label: 'Senha',
                obscureText: true,
                controller: _passwordEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.min(
                      6, 'Senha precisa ter no mínimo 6 caracteres'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CuidapetTextFormField(
                label: 'Confirme a senha',
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.required('Confirmação de senha obrigatória'),
                  Validatorless.min(
                      6, 'Senha precisa ter no mínimo 6 caracteres'),
                  Validatorless.compare(_passwordEC, 'As senhas não conferem'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CuidapetDefaultButton(
                onPressed: () {
                  final formValid = _formKey.currentState?.validate() ?? false;
                  if (formValid) {
                    controller.register(
                      email: _loginEC.text,
                      password: _passwordEC.text,
                    );
                  }
                },
                label: 'Cadastrar',
              )
            ],
          ),
        ));
  }
}
