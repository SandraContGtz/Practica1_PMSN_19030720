import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ImagePicker _picker = ImagePicker();
  final _FormKey = GlobalKey<FormState>();
  PickedFile? _imageFile;
  final firstname = TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: 'First Name',
        labelText: 'First name',
        prefixIcon: Icon(Icons.person)),
    validator: MultiValidator(
      [RequiredValidator(errorText: 'Required*')],
    ),
  );

  final email = TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: 'Email',
        labelText: 'Email',
        prefixIcon: Icon(Icons.email)),
    validator: MultiValidator(
      [
        RequiredValidator(errorText: 'Required*'),
        EmailValidator(errorText: 'Please enter your valid email'),
      ],
    ),
  );
  final lastname = TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: 'Last Name',
        labelText: 'Last name',
        prefixIcon: Icon(Icons.person)),
    validator: MultiValidator(
      [RequiredValidator(errorText: 'Required*')],
    ),
  );
  final spaceHorizont = SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    //_imageFile!;
    final btnEmail = TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 246, 148, 171),
        foregroundColor: Color.fromARGB(255, 29, 4, 4),
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        (_FormKey.currentState?.validate()) == true
            ? Navigator.pushNamed(context, '/login')
            : print("Button pressed");

        //print("Button pressed");
        //Navigator.pushNamed(context, '/login');
      },
      child: const Text("Register"),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Color.fromARGB(255, 246, 148, 171),
      ),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _FormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                spaceHorizont,
                imageProfile(),
                spaceHorizont,
                spaceHorizont,
                firstname,
                spaceHorizont,
                lastname,
                spaceHorizont,
                email,
                spaceHorizont,
                btnEmail
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? const AssetImage("assets/img.png") as ImageProvider
                : FileImage(File(_imageFile!.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
