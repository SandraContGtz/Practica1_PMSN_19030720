import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:psmna10/provider/flags_provider.dart';
import 'package:psmna10/screens/photo_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController newn = TextEditingController();
  ValueNotifier<XFile?> image = ValueNotifier<XFile?>(null);
  ValueNotifier<bool> cname = ValueNotifier<bool>(false);
  Color primarycolor = Colors.blue;
  Color redcolor = Colors.red;
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Color.fromARGB(255, 205, 153, 207),
        //Color.fromARGB(255, 246, 148, 171),
      ),
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            CircleAvatar(
                child: ValueListenableBuilder(
                    valueListenable: image,
                    builder: (context, value, child) {
                      return FirebaseAuth.instance.currentUser!.photoURL != null
                          ? value?.path == null
                              ? FirebaseAuth.instance.currentUser?.photoURL!
                                          .contains('firebasestorage') ==
                                      true
                                  ? CachedNetworkImage(
                                      imageUrl: FirebaseAuth
                                          .instance.currentUser!.photoURL!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset('assets/avatar.png')
                              : Image.file(
                                  File(value!.path),
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                          : Image.asset('assets/avatar.png');
                    })),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.teal,
                      size: 30,
                    ))
              ],
            ),
            Row(
              children: [
                /*Text(
                  'Name: ',
                  style: GoogleFonts.abel(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
                  textAlign: TextAlign.center,
                ),*/
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: cname,
                        builder: (context, value, child) {
                          return Text(
                            FirebaseAuth.instance.currentUser!.displayName!,
                            style: GoogleFonts.abel(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                            textAlign: TextAlign.center,
                          );
                        })),
                IconButton(
                    onPressed: () {
                      AlertDialog alert = AlertDialog(
                        title: Text("Change Name"),
                        content: Expanded(
                          child: TextFormField(
                            controller: newn,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: 'New Name',
                              labelText: 'New Name',
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            child: Text("Cancelar"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(redcolor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            onPressed: () {
                              print("Cancelando..");

                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: Text("Aceptar"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primarycolor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                FirebaseAuth.instance.currentUser!
                                    .updateDisplayName(newn.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Nombre actualizado correctamente')));
                              });
                              // Otras acciones de eliminar
                            },
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            Row(
              children: [
                /*Text(
                  'Email: ',
                  style: GoogleFonts.abel(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  textAlign: TextAlign.center,
                ),*/
                Expanded(
                  child: Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 25)),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 205, 153, 207),
                  foregroundColor: Color.fromARGB(255, 29, 4, 4),
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  if (image.value != null) {
                    final uploaded = await uploadImage(File(image.value!.path));
                    if (uploaded) {
                      flag.setFlagListPost(true);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Imagen subida correctamente')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Error al subir la imagen')));
                    }
                  }
                  ;
                },
                child: Text('Save changes')),
          ],
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
                  ? const AssetImage("assets/avatar.png") as ImageProvider
                  : uploadImage(File(_imageFile!.path)) as ImageProvider),
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
    image.value =
        await _picker.pickImage(source: source); // ImageSource.camera);
    /*final pickedFile = await _picker.getImage(
      source: source,
    );*/
    /*setState(() {
      _imageFile = pickedFile;
    });*/
  }

  showConfirmDelete(BuildContext context) {
    Widget cancelButton = ElevatedButton(
      child: Text("Cancelar"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(redcolor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onPressed: () {
        print("Cancelando..");

        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Aceptar"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primarycolor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onPressed: () {
        FirebaseAuth.instance.currentUser!.updateDisplayName(newn.text);
        print("Eliminando..");

        Navigator.of(context).pop();
        // Otras acciones de eliminar
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Change Name"),
      content: TextFormField(
        controller: newn,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: 'New Name',
          labelText: 'New Name',
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
