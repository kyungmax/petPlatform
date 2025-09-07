import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pw = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _form,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const FlutterLogo(size: 72),
                const SizedBox(height: 16),
                Text('로그인', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: '이메일'),
                  validator: (v) =>
                      (v == null || !v.contains('@')) ? '이메일을 입력하세요' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _pw,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 4) ? '4자 이상' : null,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _loading
                      ? null
                      : () async {
                          if (!_form.currentState!.validate()) return;
                          setState(() => _loading = true);
                          await Future.delayed(const Duration(seconds: 1)); // 로딩 모사
                          if (!mounted) return;
                          setState(() => _loading = false);
                          if (_email.text.contains('fail')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('로그인 실패(모사)')),
                            );
                          } else {
                            context.go('/home');
                          }
                        },
                  child: _loading
                      ? const SizedBox(
                          width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('로그인'),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}