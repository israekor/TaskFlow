import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Formulaire
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs des champs
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController authController = AuthController();

  bool isLoading = false;

  // Méthode d'inscription
  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Vérifier si l'email existe déjà
      bool exists = await authController.emailExists(emailController.text);

      if (exists) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Cet email existe déjà")));
      } else {
        User user = User(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        await authController.register(user);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Inscription réussie")));

        Navigator.pop(context);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un compte")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              const SizedBox(height: 30),

              // Nom
              TextFormField(
                controller: nameController,

                decoration: const InputDecoration(
                  labelText: "Nom",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Entrez votre nom";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Email
              TextFormField(
                controller: emailController,

                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Entrez votre email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Mot de passe
              TextFormField(
                controller: passwordController,

                obscureText: true,

                decoration: const InputDecoration(
                  labelText: "Mot de passe",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Minimum 6 caractères";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // Bouton inscription
              SizedBox(
                width: double.infinity,

                height: 50,

                child: ElevatedButton(
                  onPressed: isLoading ? null : register,

                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("S'inscrire"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
