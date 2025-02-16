import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oev_mobile_app/config/constants/environment.dart';

class VideoUploader {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );
  final String backendUrl = '/s3/file/upload-url';
  final String bucketName = Environment.bucketName;

  /// Permite al usuario seleccionar un video desde la galería
  Future<File?> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /// Obtiene la URL firmada para subir el video
  Future<String?> getPresignedUrl(String fileName) async {
    try {
      final response = await _dio.get(
        backendUrl,
        queryParameters: {
          'bucketName': bucketName,
          'key': fileName,
          'durationSeconds': 300, // Expira en 5 minutos
        },
      );

      if (response.statusCode == 200) {
        print(response.data['url']);
        return response.data['url'];
      }
    } catch (e) {
      print("Error al obtener la URL firmada: $e");
    }
    return null;
  }

  Future<bool> uploadVideoToS3(File videoFile, String presignedUrl) async {
    try {
      print("Iniciando subida del video...");

      // Abre el archivo en modo lectura binaria
      var fileStream = videoFile.openRead();
      var length = await videoFile.length();

      final response = await _dio.put(
        presignedUrl,
        data: fileStream, // Envía el archivo como stream
        options: Options(
          headers: {
            "Content-Type": "video/mp4", // Tipo de contenido
            "Content-Length": length.toString(), // Tamaño del archivo (importante para S3)
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Video subido con éxito!");
        return true;
      } else {
        print("Error al subir el video: ${response.statusCode}");
      }
    } catch (e) {
      print("Excepción al subir el video: $e");
    }
    return false;
  }

  /// Función principal: selecciona un video, obtiene la URL firmada y lo sube a S3
  Future<void> pickAndUploadVideo() async {
    File? videoFile = await pickVideo();
    if (videoFile == null) {
      print("No se seleccionó ningún video.");
      return;
    }

    String fileName = 'prueba.mp4'; // Puedes cambiar esto dinámicamente
    String? presignedUrl = await getPresignedUrl(fileName);

    if (presignedUrl == null) {
      print("No se pudo obtener la URL firmada.");
      return;
    }

    bool success = await uploadVideoToS3(videoFile, presignedUrl);
    if (success) {
      print("Video subido correctamente!");
    } else {
      print("Hubo un problema en la subida.");
    }
  }
}
