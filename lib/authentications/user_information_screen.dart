import 'dart:io';

import 'package:clone_gpt/provider/authentication_provider.dart';
import 'package:clone_gpt/service/assets_manager.dart';
import 'package:clone_gpt/utility/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:intl/intl.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  File? finalImageFile;
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    // fix below line !!!!!
    // phoneController.text = authProvider.phoneNumber;
  }

  final RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  void selectImage(bool fromCamera) async {
    finalImageFile = await pickImage(context: context, fromCamera: fromCamera);
    if (finalImageFile != null) {
      cropImage(finalImageFile!.path);
    }
  }

  void cropImage(filePath) async {
    CroppedFile? cropperFile = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 800, maxWidth: 800);
    popThePickImageDialog();
    if (cropperFile != null) {
      setState(() {
        finalImageFile = File(cropperFile.path);
      });
    }
  }

  void popThePickImageDialog() {
    Navigator.pop(context);
  }

  void showImagePickerDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    selectImage(true);
                  },
                  child: const Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.purple,
                        ),
                      ),
                      Text('Camera'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    selectImage(false);
                  },
                  child: const Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.purple,
                        ),
                      ),
                      Text('Amblums'),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                  Center(
                    child: finalImageFile == null
                        ? Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    AssetImage(AssetsManager.userIcon),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(
                                      width: 0.7,
                                      color: Colors.white,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      color: Colors.white,
                                      onPressed: () {
                                        showImagePickerDialog();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    FileImage(File(finalImageFile!.path)),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(
                                      width: 0.7,
                                      color: Colors.white,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      color: Colors.white,
                                      onPressed: () {
                                        showImagePickerDialog();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Register Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        myTextFormField(
                          hintText: 'Enter your name',
                          icon: Icons.account_circle,
                          textInputType: TextInputType.name,
                          maxLines: 1,
                          maxLength: 50,
                          textEditingController: nameController,
                          enable: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        myTextFormField(
                          hintText: 'Date of birth',
                          textInputType: TextInputType.datetime,
                          maxLines: 1,
                          maxLength: 50,
                          textEditingController: dobController,
                          enable: true,
                          icon: Icons.abc,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RoundedLoadingButton(
                      controller: buttonController,
                      onPressed: () {},
                      successIcon: Icons.check,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      color: Colors.grey,
                      child: const Text(
                        'Save',
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

  Widget myTextFormField({
    required String hintText,
    required IconData icon,
    required TextInputType textInputType,
    required int maxLines,
    required int maxLength,
    required TextEditingController textEditingController,
    required bool enable,
  }) {
    return TextFormField(
      enabled: enable,
      readOnly: textInputType == TextInputType.datetime,
      cursorColor: const Color.fromARGB(255, 254, 254, 254),
      controller: textEditingController,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: Container(
          margin: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 60, 150, 86),
          ),
        ),
        suffixIcon: textInputType == TextInputType.datetime
            ? IgnorePointer(
                ignoring: !enable,
                child: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: enable ? () => _selectedDate(context) : null,
                  color: Colors.white,
                ),
              )
            : null,
        hintText: hintText,
        alignLabelWithHint: true,
        border: InputBorder.none,
        fillColor: Colors.black,
        filled: true,
      ),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // final formattefDate = DateFormat('dd/MM/yyyy').format(picked);

      dobController.text = DateFormat('dd/MM/yyyy').format(picked).toString();
    }
  }
}
