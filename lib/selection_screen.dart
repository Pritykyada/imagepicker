import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class imagePicker extends StatefulWidget {
  const imagePicker({super.key});

  @override
  State<imagePicker> createState() => _imagePickerState();
}

class _imagePickerState extends State<imagePicker> {
  List<XFile> photos=[];
  List<XFile> allSelectedPhotos=[];

  Future<void> selectImage(BuildContext context) async {
    print("call");
    ImagePicker imagePicker = ImagePicker();

    final List<XFile> images = await imagePicker.pickMultiImage();
    if (images.isNotEmpty) {
      for(XFile data in images )
        {

        }
      allSelectedPhotos.addAll(images);
      photos = allSelectedPhotos;
    }
    print(allSelectedPhotos!.length);
    //photos = images.map((e) => File(e.path)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            InkWell(
              onTap: () => selectImage(context),
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
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: allSelectedPhotos!.length,
                        itemBuilder: (context, index) => Card(
                          child:
                              Image.file(File(allSelectedPhotos![index].path)),

                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
