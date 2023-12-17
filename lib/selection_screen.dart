import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class imagePicker extends StatefulWidget {
  const imagePicker({super.key});

  @override
  State<imagePicker> createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  List<File> allSelectedPhotos = [];
  List<File> currentSelected = [];
  int maxImage = 0;
  bool selection = false;

  Future<void> selectImage(BuildContext context) async {
    //_requestGalleryPermission();
    //print("call");
    try {
      ImagePicker imagePicker = ImagePicker();
      final List<XFile> images = await imagePicker.pickMultiImage();

      currentSelected = images.map((e) => File(e.path)).toList();
      print(currentSelected.length);

      selection ? secondTimeSelected() : firstTimeselection();

      setState(() {});
    } catch (e) {
      print("-------------------------------->${e.toString()}");
    }
  }

  void firstTimeselection() {
    print("selected");
    if (currentSelected.length >= 5) {
      for (int i = 0; i < 5; i++) {
        allSelectedPhotos.add(currentSelected[i]);
      }
      maxImage = 5;
    } else {
      print("call else");
      for (int i = 0; i < currentSelected.length; i++) {
        allSelectedPhotos.add(currentSelected[i]);
      }
      maxImage = currentSelected.length;
      selection = true;
    }
  }

  Future<void> _requestGalleryPermission(BuildContext context) async {
    PermissionStatus cemeraStatus = await Permission.camera.request();
    if (cemeraStatus == PermissionStatus.granted) {
      print("------------->$cemeraStatus");
      selectImage(context);
    }

    if (cemeraStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("not give permission")),
      );
    }
    if (cemeraStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  void secondTimeSelected() {
    for (int i = 0; i < currentSelected.length; i++) {
      if (!allSelectedPhotos.any((element) =>
          element.path.split("/").last ==
          currentSelected[i].path.split('/').last)) {
        maxImage++;
        if (maxImage == 6) {
          break;
        }
        allSelectedPhotos.add(currentSelected[i]);
        print(maxImage);
        print("notequal");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
            content: Column(
          children: [
            Text("Same Image Selected"),
            Text("Plase select new images "),
          ],
        )));
        print(maxImage);
        print("equal");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            InkWell(
              onTap: () => maxImage >= 5
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(

                        behavior: SnackBarBehavior.floating,
                        //behavior: SnackBarBehavior.fixed,
                        //clipBehavior: Clip.antiAlias,
                        //elevation: 12,
                      //  action: SnackBarAction(label: label, onPressed: onPressed),
                        dismissDirection: DismissDirection.horizontal,
                        content: Column(
                          children: [
                            Text(
                              "you can only select 5 image",
                            ),
                            Text("you can no more select image"),
                          ],
                        ),
                      ),
                    )
                  : _requestGalleryPermission(context),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2)),
                  child: const Icon(Icons.photo_camera,
                      color: Colors.red, size: 60),
                ),
              ),
            ),
            allSelectedPhotos.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      itemCount: allSelectedPhotos.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        // mainAxisExtent: 600,
                        childAspectRatio: 2 / 2,
                        maxCrossAxisExtent: 150,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                              boxShadow: ([
                                BoxShadow(
                                    color: Colors.black,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 23),
                              ])

                              // borderRadius: BorderRadius.circular(12),
                              ),
                          child: Image.file(allSelectedPhotos[index],
                              fit: BoxFit.fill),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
