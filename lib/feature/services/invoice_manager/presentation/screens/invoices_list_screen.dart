import 'package:business_manager/core/supabase/supabase_bucket_manager.dart';
import 'package:flutter/material.dart';

class InvoicesListScreen extends StatefulWidget {
  const InvoicesListScreen({Key? key}) : super(key: key);

  @override
  _InvoicesListScreenState createState() => _InvoicesListScreenState();
}

class _InvoicesListScreenState extends State<InvoicesListScreen> {
  final SupabaseBucketManager _bucketManager = SupabaseBucketManager();
  List<String> _files = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFiles();
  }

  Future<void> _fetchFiles() async {
    try {
      final files = await _bucketManager.listFiles('invoices/');
      setState(() {
        _files = files;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching files: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadFile(String fileName) async {
    try {
      final savePath = '/path/to/save/${fileName}';
      await _bucketManager.downloadFile('invoices/$fileName', savePath);
      print('File downloaded successfully!');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded Files'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _files.length,
        itemBuilder: (context, index) {
          final fileName = _files[index];
          return ListTile(
            title: Text(fileName),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () => _downloadFile(fileName),
            ),
          );
        },
      ),
    );
  }
}
