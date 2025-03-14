import 'dart:developer';

import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

Future<XFile> getThumbnail(String path) async {
  try {
    final thumb = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );

    return thumb;
  } catch (e) {
    log("Thumbnail Error: $e");
    throw Exception("The thumbnail could not be generated");
  }
}
