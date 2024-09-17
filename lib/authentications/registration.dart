import 'package:clone_gpt/authentications/login_screen.dart';
import 'package:clone_gpt/provider/authentication_provider.dart';
import 'package:clone_gpt/service/assets_manager.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final TextEditingController confirmPasswordControler =
      TextEditingController();
  int fontSizeText = 14;
  int fontSizeHeader = 22;
  bool _showPassword = false;
  bool ispasswordChanged = false;
  bool iscomfirmPasswordChanged = false;
  bool isphoneNumberChanged = false;
  Country selectedCountry = Country(
      phoneCode: '84',
      countryCode: 'VN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Viet Nam',
      example: 'Viet Nam',
      displayName: 'Viet Nam',
      displayNameNoCountryCode: 'VN',
      e164Key: '');
  final RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  void dispose() {
    phoneController.dispose();
    buttonController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginScreen(),
                          ),
                        );
                      },
                      color: Colors.black,
                    ),
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
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    textAlign: TextAlign.center,
                    'Your Phone number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phoneController,
                    maxLength: 11,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                        iscomfirmPasswordChanged = true;
                      });
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 60, 150, 86),
                        ),
                      ),
                      prefixIcon: Container(
                        padding:
                            const EdgeInsets.fromLTRB(5.0, 12.0, 8.0, 12.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 500),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },
                            );
                          },
                          child: Text(
                            '${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.isEmpty
                          ? null
                          : phoneController.text.length >= 10
                              ? const Icon(
                                  Icons.done,
                                  size: 22,
                                  color: Color.fromARGB(255, 51, 172, 47),
                                )
                              : const Icon(
                                  Icons.error,
                                  size: 22,
                                  color: Color.fromARGB(255, 218, 80, 75),
                                ),
                    ),
                  ),

                  const Text(
                    textAlign: TextAlign.center,
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextFormField(
                    controller: passwordControler,
                    maxLength: 50,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_showPassword,
                    onChanged: (value) {
                      setState(() {
                        passwordControler.text = value;
                        ispasswordChanged = true;
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          // Đổi màu của thanh dưới khi trường nhập được chọn thành màu đen
                          color: Color.fromARGB(255, 60, 150, 86),
                        ),
                      ),
                      suffixIcon: passwordControler.text.isEmpty
                          ? null
                          : passwordControler.text.length >= 6
                              ? const Icon(
                                  Icons.done,
                                  size: 22,
                                  color: Color.fromARGB(255, 51, 172, 47),
                                )
                              : const Icon(
                                  Icons.error,
                                  size: 22,
                                  color: Color.fromARGB(255, 218, 80, 75),
                                ),
                    ),
                  ),

                  // password again
                  const Text(
                    textAlign: TextAlign.center,
                    'Confirm password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: confirmPasswordControler,
                    maxLength: 50,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_showPassword,
                    onChanged: (value) {
                      setState(() {
                        confirmPasswordControler.text = value;
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 60, 150, 86),
                        ),
                      ),
                      suffixIcon: confirmPasswordControler.text.isEmpty
                          ? null
                          : confirmPasswordControler.text ==
                                  passwordControler.text
                              ? const Icon(
                                  Icons.done,
                                  size: 22,
                                  color: Color.fromARGB(255, 51, 172, 47),
                                )
                              : const Icon(
                                  Icons.error,
                                  size: 22,
                                  color: Color.fromARGB(255, 218, 80, 75),
                                ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor:
                          Colors.grey, // Màu của viền xung quanh ô đánh dấu
                      textTheme: const TextTheme(
                        titleMedium: TextStyle(
                            color: Colors.black), // Màu của văn bản đi kèm
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          value: _showPassword,
                          onChanged: (value) {
                            setState(() {
                              _showPassword = value!;
                            });
                          },
                        ),
                        const Text(
                          'Show password',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RoundedLoadingButton(
                      controller: buttonController,
                      onPressed: () {
                        sendPhoneNumber();
                      },
                      successIcon: Icons.check,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      color: Colors.grey,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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

  void sendPhoneNumber() {
    final authRepo = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    String phoneNumber = phoneController.text.trim();
    String fullPhoneNumber = '${selectedCountry.phoneCode}$phoneNumber';
    // String fulPhoneNumber =
    //     convertToE164(phoneNumber, selectedCountry.countryCode);

    print(selectedCountry.countryCode);
    print(phoneNumber);
    print(fullPhoneNumber);
    authRepo.signInWithPhone(
      context: context,
      phoneNumber: fullPhoneNumber,
      buttonController: buttonController,
    );
  }
}

// String convertToE164(String phoneNumber, String countryCode) {
//   // Thêm mã quốc gia nếu cần thiết
//   if (!phoneNumber.startsWith(countryCode)) {
//     phoneNumber = countryCode + phoneNumber;
//   }
//   // Loại bỏ bất kỳ ký tự không hợp lệ nào
//   phoneNumber = cleanPhoneNumber(phoneNumber);
//   return '+$phoneNumber';
// }

// String cleanPhoneNumber(String phoneNumber) {
//   // Loại bỏ các ký tự không cần thiết
//   phoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
//   return phoneNumber;
// }


 // if (passwordControler.text ==
                        //         confirmPasswordControler.text &&
                        //     phoneController.text.length >= 10) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => OTPScreen(
                        //         phoneNumber: phoneController.text,
                        //       ),
                        //     ),
                        //   );
                        // } else {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const RegistrationScreen(),
                        //     ),
                        //   );
                        // }
