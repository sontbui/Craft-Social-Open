import 'package:clone_gpt/authentications/registration.dart';
import 'package:clone_gpt/main_screnn/home_screen.dart';
import 'package:clone_gpt/service/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailOrPhoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  final RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    emailOrPhoneNumberController.dispose();
    passwordController.dispose();
    buttonController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsManager.appLogo),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'RedditMono',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color.fromARGB(211, 11, 11, 11),
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                const BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromARGB(211, 11, 11, 11),
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: emailOrPhoneNumberController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'RedditMono',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(
                                      fontFamily: 'RedditMono',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(200, 45, 44, 44),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: !showPassword,
                                  controller: passwordController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'RedditMono',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: const TextStyle(
                                      fontFamily: 'RedditMono',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(200, 45, 44, 44),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color.fromARGB(
                                            255, 108, 108, 108),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RoundedLoadingButton(
                          controller: buttonController,
                          onPressed: () {
                            if (emailOrPhoneNumberController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            }
                          },
                          successIcon: Icons.check,
                          successColor: Colors.green,
                          errorColor: Colors.red,
                          color: const Color.fromARGB(255, 198, 197, 197),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'RedditMono',
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontFamily: 'RedditMono',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: 'RedditMono',
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              AssetsManager.googleLogo,
                              width: 35,
                              height: 24,
                            ),
                            label: const Text(
                              'Google',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 198, 197, 197),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              AssetsManager.facebookLogo,
                              width: 24,
                              height: 24,
                            ),
                            label: const Text(
                              'Facebook',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 198, 197, 197),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
