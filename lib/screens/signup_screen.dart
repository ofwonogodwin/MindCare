import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/constants/app_routes.dart';
import '../presentation/controllers/app_session_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/developed_by_footer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();
  bool _anonymousProfile = false;
  bool _termsAccepted = false;
  bool _confidentialityAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime(2005),
    );
    if (picked == null) return;
    _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_termsAccepted || !_confidentialityAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept Terms and Confidentiality Agreement.'),
        ),
      );
      return;
    }

    final displayName = _anonymousProfile
        ? (_nameController.text.trim().isEmpty
              ? 'Anonymous Student'
              : _nameController.text.trim())
        : _nameController.text.trim();

    await AppSessionController.login(
      anonymousMode: _anonymousProfile,
      displayName: displayName,
    );
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registration successful.')));
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  String? _emptyValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Join MindCare',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name / Pseudonym',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (_anonymousProfile) return null;
                            return _emptyValidator(value, 'Full name');
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (_anonymousProfile) return null;
                            return _emptyValidator(value, 'Email');
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number (optional)',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _dobController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Date of Birth (optional)',
                            prefixIcon: const Icon(Icons.cake_outlined),
                            suffixIcon: IconButton(
                              onPressed: _pickDob,
                              icon: const Icon(Icons.calendar_month_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) => _anonymousProfile
                              ? null
                              : _emptyValidator(value, 'Password'),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_person_outlined),
                          ),
                          validator: (value) {
                            final emptyCheck = _emptyValidator(
                              value,
                              'Confirm password',
                            );
                            if (_anonymousProfile) return null;
                            if (emptyCheck != null) return emptyCheck;
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        CheckboxListTile(
                          value: _anonymousProfile,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Use anonymous profile'),
                          subtitle: const Text(
                            'You can use a pseudonym. Your information is confidential.',
                          ),
                          onChanged: (value) {
                            setState(() => _anonymousProfile = value ?? false);
                          },
                        ),
                        CheckboxListTile(
                          value: _termsAccepted,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('I agree to Terms & Conditions'),
                          onChanged: (value) {
                            setState(() => _termsAccepted = value ?? false);
                          },
                        ),
                        CheckboxListTile(
                          value: _confidentialityAccepted,
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'I agree to confidentiality policy',
                          ),
                          onChanged: (value) {
                            setState(
                              () => _confidentialityAccepted = value ?? false,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _register,
                          child: const Text('Register'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          },
                          child: const Text('Already have an account? Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const DevelopedByFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
