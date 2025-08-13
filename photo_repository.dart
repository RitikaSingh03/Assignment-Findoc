import 'dart:convert';
import 'package:http/http.dart' as http;
import 'photo_model.dart';

class PhotoRepository {
  Future<List<Photo>> fetchPhotos() async {
    final response =
        await http.get(Uri.parse("https://picsum.photos/v2/list?limit=10"));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load photos");
    }
  }
}
