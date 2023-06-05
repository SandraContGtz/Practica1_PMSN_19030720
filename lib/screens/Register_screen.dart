import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/firebase/email_auth.dart';
import 'package:psmna10/provider/color_provider.dart';
import 'package:psmna10/screens/photo_screen.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailUser = TextEditingController();
  TextEditingController passwordUser = TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController lastnam=TextEditingController();
  String? username;
  EmailAuth emailAuth = EmailAuth();
  final ImagePicker _picker = ImagePicker();
  final _FormKey = GlobalKey<FormState>();
  PickedFile? _imageFile;
  
  
 
  

  @override
  Widget build(BuildContext context) {
    ColorProvider colorApp = Provider.of<ColorProvider>(context);
    //_imageFile!;
  final firstname = TextFormField(
    controller: name,
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

  final lastname = TextFormField(
    controller: lastnam,
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: colorApp.getColorBar(),
        //Color.fromARGB(255, 246, 148, 171),
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
                TextFormField(
                  controller: emailUser,
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
  ),
                spaceHorizont,
                TextFormField(
                  controller: passwordUser,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: true,
    decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: 'Password',
        labelText: 'Password',
        prefixIcon: Icon(Icons.password)),
    validator: MultiValidator(
      [RequiredValidator(errorText: 'Required*')],
    ),
  ),
                spaceHorizont,
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: colorApp.getColorBar(),
                    //Color.fromARGB(255, 246, 148, 171),
                    foregroundColor: Color.fromARGB(255, 29, 4, 4),
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () 
                  
                  async{
                     if (_imageFile!.path != null) {  
                          final uploaded = await uploadImage(File(_imageFile!.path));
                          if (uploaded) {
                            //flag.setflagListPost();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Imagen subida correctamente')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Error al subir la imagen')));
                            }
                        }
                    if (_FormKey.currentState!.validate() == true) {
                      try{
                          username=name.text+' '+lastnam.text;
                          emailAuth.registerWithEmailAndPassword(
                          email: emailUser.text,
                          password: passwordUser.text,
                          ).then((value) {
                          FirebaseAuth.instance.currentUser!.updateDisplayName(username);

          if (value) {
            //user!.sendEmailVerification();
            //user!.displayName!=username.text;
            Navigator.pushNamed(context, '/dash');
          }
        });
      } catch (e) {
        AlertDialog(
          title: Text("Error"),
          content: Text("Ocurrió un error al procesar la información, por favor, vuelve a intentarlo"),
          actions: [
            TextButton(onPressed: (){MaterialPageRoute(builder: (context)=> RegisterScreen());}, child: Text('Aceptar'))
          ],
        );
      }
    } else {
      AlertDialog(
          title: Text("Error"),
          content: Text("Verifica que los datos sean correctos."),
          actions: [
            TextButton(onPressed: (){MaterialPageRoute(builder: (context)=> RegisterScreen());}, child: Text('Aceptar'))
          ],
        );
    }
                  
                  /*{
                    if (_FormKey.currentState!.validate() == true) {
                      emailAuth.registerWithEmailAndPassword(
                          email: emailUser.text,
                          password: passwordUser.text);
                      Navigator.pushNamed(context, '/dash');
                    }*/

                    /*(_FormKey.currentState?.validate()) == true
            ? emailAuth.createUserWithEmailAndPassword(email: emailUser.text, password: passwordUser.text);
            //Navigator.pushNamed(context, '/login')
            : print("Button pressed");*/
                  },
                  child: const Text("Register"),
                )
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
