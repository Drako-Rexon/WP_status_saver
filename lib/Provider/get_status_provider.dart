import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wp_status_saver/constants/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';

class GetStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = <FileSystemEntity>[];
  List<FileSystemEntity> _getVideos = <FileSystemEntity>[];
  bool _isWhatsAppAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;
  bool get isWhatsAppAvailable => _isWhatsAppAvailable;

  void getStatus(String ext) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    PermissionStatus status;
    AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;

    if (info.version.sdkInt < 33) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.manageExternalStorage.request();
    }

    if (status.isDenied) {
      await Permission.storage.request();
      log("Permission Denied");
      await Fluttertoast.showToast(
          msg: "The permission has been denied by the user.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (status.isGranted) {
      final directory = Directory(AppConstants.WHATSAPP_PATH);

      if (directory.existsSync()) {
        final items = Directory(AppConstants.WHATSAPP_PATH).listSync();

        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        } else {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }
        _isWhatsAppAvailable = true;
        notifyListeners();

        log(_getVideos.toString());
      } else {
        _isWhatsAppAvailable = false;
        log("No WhtsApp Found");
      }

      return;
    }
  }
}
