import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';

int profilepictureaddingcount = 0;

class ProfileImagePage extends StatefulWidget {
  const ProfileImagePage({Key? key}) : super(key: key);

  @override
  ProfileImagePageState createState() => ProfileImagePageState();
}

class ProfileImagePageState extends State<ProfileImagePage> {
  File? image;
  final ImageCropper imageCropper = ImageCropper();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Column(
        children: [
          const SizedBox(height: 80),
          SizedBox(
            width: 200,
            child: Row(
              children: [

                Image.asset(
                  'lib/assets/images/isolated-young-handsome-man-different-poses-white-background-illustration_632498-859.jpg',
                  height: 40,
                  width: 40,
                ),

               
                const HeadingTextstyle(
                  content: '  Add Image',
                  fontsize: 25,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          if (currentRessume?.profileimage != null&&currentRessume?.profileimage != '')
            Image.file(File(currentRessume?.profileimage ?? ''),
                width: 200, height: 200),
          if (currentRessume?.profileimage == null||currentRessume?.profileimage == '')
            Container(
                decoration:const  BoxDecoration(
                    color: Color.fromARGB(255, 141, 92, 182),
                   ),
                child:Image.asset(
                  'lib/assets/images/isolated-young-handsome-man-different-poses-white-background-illustration_632498-859.jpg',
                   width: 200, height: 200

               
                ),
                
                ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(fourthcolor),
                iconColor: WidgetStatePropertyAll(fourthcolor)),
            onPressed: pickImage,
            child: const Text("Select Image",style: TextStyle(color: Colors.white),), 
          ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final croppedFile = await imageCropper.cropImage(
            sourcePath: pickedFile.path,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        if (croppedFile != null) {
          final directory = await getApplicationDocumentsDirectory();

          if (currentRessume?.profileimage != null) { 
            profilepictureaddingcount = profilepictureaddingcount + 1;
          }

          final file = File(
              '${directory.path}/profile_image$profilepictureaddingcount.png');
          await file.writeAsBytes(await croppedFile.readAsBytes());
          setState(() {
            image = null;
            currentRessume?.profileimage = file.path;
            updateResume();
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }
    }
  }
}
