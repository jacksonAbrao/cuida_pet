import 'package:cuida_pet/app/modules/core/auth/auth_store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final AuthStore _authStore;
  const HomePage({Key? key, required AuthStore authStore})
      : _authStore = authStore,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Loggout'),
          onPressed: () {
            _authStore.logout();
          },
        ),
      ),
    );
  }
}
