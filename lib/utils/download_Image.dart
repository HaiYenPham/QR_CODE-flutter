import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

void save_img(String url, BuildContext context) async {
  try {
    // Saved with this method.
    var imageId = await ImageDownloader.downloadImage(url);
    if (imageId == null) {
      EdgeAlert.show(context,
          title: 'Failed',
          description: 'Saving is failed',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    } else {
      EdgeAlert.show(context,
          title: 'Saved',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.green);
    }
  } catch (error) {
    print(error);
  }
}
