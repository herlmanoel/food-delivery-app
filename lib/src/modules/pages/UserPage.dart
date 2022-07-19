import 'dart:io';

import 'package:ecommercefood/src/modules/components/Anexo.dart';
import 'package:ecommercefood/src/modules/components/NavBar.dart';
import 'package:ecommercefood/src/modules/pages/PreviewPage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefood/src/shared/themes/app_image.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  File? image;

  Future pickImage(ImageSource Source) async {
    try {
      final image = await ImagePicker().pickImage(source: Source);

      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Falha em pegar a foto!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image != null
                    ? ClipOval(
                      child: Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ))
                    : Image.asset(AppImages.delivery),
                // if (image != null) Anexo(image: image!),
                const SizedBox(height: 48),
                OutlinedButton.icon(
                  icon: Icon(Icons.attach_file),
                  label: Text('Selecione um image'),
                  onPressed: () => pickImage(ImageSource.gallery),
                ),
                OutlinedButton.icon(
                  icon: Icon(Icons.camera),
                  label: Text('Tirar uma foto'),
                  onPressed: () => pickImage(ImageSource.camera),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
