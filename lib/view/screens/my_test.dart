import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class DocumentUploader extends StatefulWidget {
  @override
  _DocumentUploaderState createState() => _DocumentUploaderState();
}

class _DocumentUploaderState extends State<DocumentUploader> {
  String buttonText = "Select a Document";
  File? selectedFile;

  Future<void> selectAndUploadDocument() async {
    try {
      // Select document using FilePicker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', "docx"], // Restrict to PDF files only
      );

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
          buttonText = result.files.single.name;
        });

        print(
            "Yesss ${result.files.single.name} ${result.files.first.extension}");
        result.files.first.extension;

        // Upload the document
        await uploadDocument(selectedFile!);
      } else {
        // User canceled the picker
        setState(() {
          buttonText = "No Document Selected";
        });
      }
    } catch (e) {
      print("Error selecting document: $e");
    }
  }

  Future<void> uploadDocument(File file) async {
    try {
      final url = Uri.parse(
          "https://your-backend-url.com/upload"); // Replace with your backend URL
      final request = http.MultipartRequest("POST", url)
        ..files.add(await http.MultipartFile.fromPath("file", file.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print("File uploaded successfully");
        setState(() {
          buttonText = "Upload Successful!";
        });
      } else {
        print("Upload failed with status: ${response.statusCode}");
        setState(() {
          buttonText = "Upload Failed";
        });
      }
    } catch (e) {
      print("Error uploading document: $e");
      setState(() {
        buttonText = "Upload Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document Uploader")),
      body: Center(
        child: ElevatedButton(
          onPressed: selectAndUploadDocument,
          child: Text(buttonText),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DocumentUploader(),
  ));
}
