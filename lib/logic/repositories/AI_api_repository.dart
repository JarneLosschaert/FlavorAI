import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class AIApiRepository {

    static const String _flaskApiIp = "192.168.113.164:9090";

    Future<String> fetchProductsFromImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$_flaskApiIp/detect_products'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        filename: path.basename(imageFile.path),
      ),
    );

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Failed to upload image. Status code: ${response.statusCode}';
      }
    } catch (err) {
      throw err.toString();
    }
  }
}