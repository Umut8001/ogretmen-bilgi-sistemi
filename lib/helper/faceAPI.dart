import 'dart:convert';
import 'dart:io';
import 'package:face_cropper/face_cropper.dart';
import 'package:http/http.dart' as http;

class FaceApiService {
  //IOS
  //static const String _apiUrl = "http://localhost:8000/api/v1/face-embedding";

  //Android
  static final String _apiUrl = "http://10.0.2.2:8000/api/v1/face-embedding";

  static Future<List<double>?> getEmbedding(File imageFile) async {
    FaceCropper faceCropper = FaceCropper();
    try {
      String? croppedPath = await faceCropper.detectFacesAndCrop(
        imageFile.path,
      );
      if (croppedPath != null) {
        imageFile = File(croppedPath);
      }

      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        print('❌ API HTTP Hatası: HTTP ${response.statusCode}');
        return null;
      }

      final Map<String, dynamic> data = json.decode(response.body);

      if (data['success'] == true) {
        final List<dynamic> rawEmbedding = data['embedding'];

        return rawEmbedding.cast<double>();
      } else {
        print("❌ API Mantıksal Hatası: ${data['error']}");
        return null;
      }
    } catch (e) {
      print(
        "❌ Bağlantı Hatası: API'ye erişilemiyor. Lütfen kontrol edin. ($e)",
      );
      return null;
    }
  }
}
