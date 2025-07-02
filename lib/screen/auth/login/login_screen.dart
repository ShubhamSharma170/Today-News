import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/routes/routes_name.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AllColors.floraWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Login"),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AllColors.black,
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
            const SizedBox(height: 30),
            SizedBox(
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
                  // login logic
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AllColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AllColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.signup);
                  },
                  child: Text(
                    "Sign Up",
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
        prefixIcon: Icon(icon, color: AllColors.orangeFF8C42),
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
