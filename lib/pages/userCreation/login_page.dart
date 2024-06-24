import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/pages/userCreation/forgot_password_page.dart';
import 'package:fit_app/pages/userCreation/signup_page.dart';
import 'package:fit_app/pages/userCreation/widgets/email_textfield.dart';
import 'package:fit_app/pages/userCreation/widgets/password_textfield.dart';
import 'package:fit_app/pages/userCreation/widgets/signin_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign user in method
  void signUserIn() async {
    final userEmail = emailController.text;
    final userPassword = passwordController.text;

    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      Navigator.pop(context); // Close the loading dialog
    } catch (error) {
      print('Error signing in: $error');
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in: $error'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.pop(context);
    }
  }

  void signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user already exists
      User? user = userCredential.user;
      if (user != null) {
        // Check if the user is a new user
        if (userCredential.additionalUserInfo!.isNewUser) {
          // Sign out the new user immediately
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account does not exist. Please sign up first.'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          print("User signed in: ${user.displayName}");
          // Proceed to your app's main page
        }
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 249, 240, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // Welcome
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Color.fromRGBO(8, 31, 92, 1),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Email textfield
              EmailTextField(controller: emailController, hintText: 'Email'),

              const SizedBox(height: 10),

              // Password textfield
              PasswordTextField(
                controller: passwordController,
                hintText: 'Password',
              ),

              const SizedBox(height: 10),

              // Forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Sign in button
              SigninButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 20),

              // Row of Google and Facebook sign-in buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: signInWithGoogle,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(8, 31, 92, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 249, 240, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //const SizedBox(width: 20),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Add your Facebook sign-in logic here
                    //   },
                    //   child: Image.asset(
                    //     'lib/assets/facebook.png',
                    //     width: 0,
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Color.fromRGBO(8, 31, 92, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Color.fromRGBO(8, 31, 92, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Color.fromRGBO(8, 31, 92, 1),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Don't have an account, sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "DON'T HAVE AN ACCOUNT?",
                    style: TextStyle(
                      color: Color.fromRGBO(8, 31, 92, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignupPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "SIGN UP HERE",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
