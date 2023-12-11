import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectUploadImage extends StatefulWidget {
  final File? image;
  final Function? getImageFromCamera;
  final Function? getImageFromGallery;

  const SelectUploadImage({
    Key? key,
    this.getImageFromCamera,
    this.getImageFromGallery,
    this.image,
  }) : super(key: key);

  @override
  State<SelectUploadImage> createState() => _SelectUploadImageState();
}

class _SelectUploadImageState extends State<SelectUploadImage> {
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              widget.getImageFromGallery!();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              widget.getImageFromCamera!();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: showOptions,
              child: const Text('Select Image'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Center(
                child: widget.image == null
                    ? const Text('No Image selected')
                    : Image.file(widget.image!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
