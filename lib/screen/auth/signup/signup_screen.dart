import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/provider/auth_provider/auth_provider.dart';
import 'package:today_news/utils/loadingIndicator.dart';
import 'package:today_news/utils/toast_message.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AllColors.floraWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign Up"),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AllColors.splashColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField(
              controller: emailController,
              label: "Email",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: passwordController,
              label: "Password",
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: confirmPasswordController,
              label: "Confirm Password",
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            SizedBox(height: height * 0.05),
            ChangeNotifierProvider(
              create: (context) => AuthProvider(),
              child: Consumer<AuthProvider>(
                builder: (ctx, provider, child) => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColors.orangeFF8C42,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // sign up logic
                      if (emailController.text.isEmpty) {
                        toastMessage("Please enter email");
                        return;
                      } else if (passwordController.text.isEmpty) {
                        toastMessage("Please enter password");
                        return;
                      } else if (confirmPasswordController.text.isEmpty) {
                        toastMessage("Please enter confirm password");
                        return;
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        toastMessage(
                          "Password and confirm password does not match",
                        );
                        return;
                      } else {
                        toastMessage("Creating account...");
                        provider.createUser(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        emailController.clear();
                        passwordController.clear();
                        confirmPasswordController.clear();
                      }
                    },
                    child: provider.isLoading
                        ? loadingIndicator()
                        : Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AllColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // navigate to login screen
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AllColors.orangeFF8C42,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFFFF8C42)),
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
