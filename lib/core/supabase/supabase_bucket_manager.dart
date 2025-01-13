import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBucketManager {
  final String bucketName = 'business_manager_bucket';


  Future<void> uploadFile(File file, String path) async {
    final userAuth = Supabase.instance.client.auth.currentUser;

    if (userAuth == null) {
      throw Exception('You must be logged in to upload a file.');
    }

    try {

      final response = await Supabase.instance.client.storage
          .from(bucketName)
          .upload(path, file);

      print('File uploaded successfully: $response');


      await Supabase.instance.client.from('file_metadata').insert({
        'user_id': userAuth.id,
        'file_path': path,
        'uploaded_at': DateTime.now().toIso8601String(),
      });

      print('Metadata saved successfully');
    } catch (error) {
      print('Error uploading file: $error');
      throw error;
    }
  }


  Future<File> downloadFile(String path, String savePath) async {
    final userAuth = Supabase.instance.client.auth.currentUser;

    if (userAuth == null) {
      throw Exception('You must be logged in to download a file.');
    }

    try {

      final response = await Supabase.instance.client.storage
          .from(bucketName)
          .download(path);


      final file = File(savePath);
      await file.writeAsBytes(response);

      print('File downloaded successfully to $savePath');
      return file;
    } catch (error) {
      print('Error downloading file: $error');
      throw error;
    }
  }


  Future<List<String>> listFiles(String folderPath) async {
    final userAuth = Supabase.instance.client.auth.currentUser;

    if (userAuth == null) {
      throw Exception('You must be logged in to list files.');
    }

    try {
      final response = await Supabase.instance.client.storage
          .from(bucketName)
          .list(path: folderPath);

      final files = response.map((file) => file.name).toList();
      print('Files in folder $folderPath: $files');
      return files;
    } catch (error) {
      print('Error listing files: $error');
      throw error;
    }
  }


  Future<void> deleteFile(String path) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('You must be logged in to delete a file.');
    }

    try {
      final response = await Supabase.instance.client.storage
          .from(bucketName)
          .remove([path]);

      print('File deleted successfully: $response');
    } catch (error) {
      print('Error deleting file: $error');
      throw error;
    }
  }
}
