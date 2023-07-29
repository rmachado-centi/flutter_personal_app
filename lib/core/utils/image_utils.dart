import 'package:flutter/material.dart';

class ImageUtils {
  static const apiUrl = 'https://api.remove.bg/v1.0/removebg';
  static const headers = {
    'X-Api-Key': 'GYRn69xk8ahoXx58joPj1Dc9',
    'accept': 'application/json'
  };

  Widget getImage(String url) {
    return Image.network(
      url,
      height: 200,
      width: 200,
    );
  }
}
