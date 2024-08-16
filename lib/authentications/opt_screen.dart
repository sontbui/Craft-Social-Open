import 'package:clone_gpt/authentications/user_information_screen.dart';
import 'package:clone_gpt/provider/authentication_provider.dart';
import 'package:clone_gpt/service/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreeenState();
}

class _OTPScreeenState extends State<OTPScreen> {
  String? smsCode;
  @override
  Widget build(BuildContext context) {
    final authRepo = Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 35,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(AssetsManager.appLogo),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    textAlign: TextAlign.center,
                    'Enter the OTP code in message',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //  input code opt
                  Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onCompleted: (value) {
                      setState(() {
                        smsCode = value;
                      });
                      // verify otp code
                      verifyOTP(smsCode: smsCode!);
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  authRepo.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.orangeAccent,
                        )
                      : const SizedBox.shrink(),
                  authRepo.isSuccessful
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.done,
                            size: 30,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Didn\'t receive any code ?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(200, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Resend new code',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(199, 1, 255, 65),
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

  void verifyOTP({required String smsCode}) {
    final authRepo =
        Provider.of<AuthenticationProvider>(context, listen: false);
    authRepo.verifyOTP(
        context: context,
        verificationId: widget.verificationId,
        smsCode: smsCode,
        onSuccess: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserInformationScreen()));
        });
  }
}
