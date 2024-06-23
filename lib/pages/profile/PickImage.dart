import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource sourceOfImg) async{
 final ImagePicker _imagePicker = ImagePicker();
 XFile? _file = await _imagePicker.pickImage(source: sourceOfImg);
 if(_file != null){
  return await _file.readAsBytes();
 }
 print('No Image Selected');
}