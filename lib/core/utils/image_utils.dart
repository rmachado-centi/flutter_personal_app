import 'package:flutter/material.dart';

class ImageUtils {
  Widget getImage(String url) {
    return Image.network(
      url,
      height: 200,
      width: 200,
    );
  }
}
