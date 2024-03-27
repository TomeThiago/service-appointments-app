import 'dart:io';

import 'package:app/components/button.dart';
import 'package:app/consts/profile.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/service/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class EditUser extends StatefulWidget {
  const EditUser({
    super.key,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthServiceProvider>();
    var user = authProvider.loggedUser;

    File? _imageFile;

    TextEditingController avatarUrlController = TextEditingController(
        text: user?.avatarUrl
    );
    TextEditingController nameController = TextEditingController(
      text: user?.name
    );
    TextEditingController cpfController = TextEditingController(
        text: user?.cpf
    );
    TextEditingController emailController = TextEditingController(
        text: user?.email
    );
    TextEditingController bioController = TextEditingController(
        text: user?.bio
    );

    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        await UserRepository().updateProfile(user!.id, nameController.text, cpfController.text, bioController.text);
        await UserRepository().updateAvatar(user.id, avatarUrlController.text);

        user.avatarUrl = avatarUrlController.text;
        user.name = nameController.text;
        user.cpf = cpfController.text;
        user.bio = bioController.text;

        authProvider.loggedUser = await UserRepository().getUserByEmail(user.email);

        Navigator.pop(context);
      }
    }

    Future<File?> pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }

      return null;
    }

    Future<String> uploadImage(File imageFile) async {
      String fileName = basename(imageFile.path);

      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    }

    void _selectImage(ImageSource source) async {
      File? selected = await pickImage(source);

      setState(() {
        _imageFile = selected;
      });
    }

    void _uploadImage() async {
      if (_imageFile == null) return;

      String imageUrl = await uploadImage(_imageFile!);
      print('Uploaded Image URL: $imageUrl');
    }

    String getAvatarUrl() {
      if(user == null) {
        return ProfileConst.avatarUrl;
      }
      if(user.avatarUrl == null) {
        return ProfileConst.avatarUrl;
      }

      if(user.avatarUrl == '') {
        return ProfileConst.avatarUrl;
      }

      return user.avatarUrl!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: avatarUrlController,
                decoration: const InputDecoration(
                  labelText: 'Foto URL',
                  hintText: 'https://',
                ),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite o seu nome completo',
                ),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Insira a nome para o cadastro';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Digite o seu CPF',
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Insira o cpf para o cadastro';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite o seu e-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Insira o e-mail para o cadastro';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: bioController,
                decoration: const InputDecoration(
                  labelText: 'Biografia',
                  hintText: 'Digite sobre você',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 32.0,
              ),
              Button(
                title: 'Confirmar',
                onPressed: handleSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
