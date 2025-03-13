import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wp_status_saver/constants/constants.dart';

class GetStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];
  bool _isWhatsAppAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;
  bool get isWhatsAppAvailable => _isWhatsAppAvailable;

  void getStatus(String ext) async {
    // for android lower than 14
    final status = await Permission.storage.request();
    final statusmanage = await Permission.manageExternalStorage.request();
    // final statusImage = await Permission.photos.request();
    // final statusVideo = await Permission.videos.request();

    // log("image status: $statusImage");
    // log("video status: $statusVideo");
    log("status: ${status.isGranted}");
    if (status.isDenied) {
      await Permission.storage.request();
      log("Permission Denied");
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
