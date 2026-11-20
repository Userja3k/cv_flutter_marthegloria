import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(builder: (_) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_pin,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Bienvenue',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Connectez-vous pour continuer',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    decoration: _inputDecoration(
                      label: 'Identifiant',
                      icon: Icons.person_outline,
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Entrez un identifiant'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: _inputDecoration(
                      label: 'Mot de passe',
                      icon: Icons.lock_outline,
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Entrez un mot de passe'
                        : null,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      onPressed: _login,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }
}
