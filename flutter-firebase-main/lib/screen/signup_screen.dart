import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/component/my_button.dart';
import 'package:onboarding_screen/component/my_textfield.dart';
import 'package:onboarding_screen/screen/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    try {
     
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error: ${e.message}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _isEmailUsed(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (error) {
      print("Error checking email usage: $error");
      return false;
    }
  }

  void _showMyDialog(BuildContext context, String txtMsg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: const Text('AlertDialog Title'),
          content: Text(txtMsg),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Text(
          'สมัครสมาชิก',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ยินดีต้อนรับสู่แอพของเรา.",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              "\nในการเริ่มต้น โปรดให้ข้อมูลของคุณและสร้างบัญชี.\n",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displaySmall,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
            MYTextfield(
              controller: fullnameController,
              labelText: "ชื่อ",
              obscureText: false,
              hintText: "Enter your name.",
            ),
            const SizedBox(height: 20),
            MYTextfield(
              controller: emailController,
              labelText: "Email",
              obscureText: false,
              hintText: "กรอก Email.",
            ),
            const SizedBox(height: 20),
            MYTextfield(
              controller: passwordController,
              labelText: "รหัสผ่าน",
              obscureText: true,
              hintText: "Enter your password.",
            ),
            const SizedBox(height: 20),
            MYTextfield(
              controller: repasswordController,
              labelText: "ยืนยันรหัสผ่าน",
              obscureText: true,
              hintText: "Enter your password again.",
            ),
            const SizedBox(height: 20),
            MyButton(
              onTap: () async {
                bool emailUsed = await _isEmailUsed(emailController.text);
                if (emailUsed) {
                  _showMyDialog(context, "อีเมลนี้ถูกใช้ไปแล้ว");
                } else {
                  createUserWithEmailAndPassword(context);
                }
              },
              hinText: "สมัครสมาชิก",
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'เป็นสมาชิกแล้ว?',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displaySmall,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(width: 1),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sign in.',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 46, 231, 55),
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
}
