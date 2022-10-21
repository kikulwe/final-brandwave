import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import "package:brandwave/utils/screens.dart";

class UploadAd extends StatefulWidget {
  const UploadAd({super.key});

  @override
  State<UploadAd> createState() => _UploadAdState();
}

class _UploadAdState extends State<UploadAd> {

  bool isLoading = false;
  bool filesSelected = false;
  List<File> ? files;

  String ? advertName;
  String ? advertDescription;

  void selectFiles () async {
    setState(() {
      isLoading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
        allowMultiple: true
    );

    if (result != null) {
      // String ? filename = result!.files.first.name;
      // PlatformFile ? pickedFile = result!.files.first;
      // File ? file = File(pickedFile.path.toString());


      files = result.paths.map((path) => File(path.toString())).toList();

      setState(() {
        filesSelected = true;
      });
    } else {
      // User canceled the picker
    }

    setState(() {
      isLoading = false;
    });
  }

  void visitLocationPage () {
    Navigator.pushNamed(
        context,
        '/selectLocation',
        arguments: AdvertScreenArguments(advertName, advertDescription, files)
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Advertisement Details",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(220, 36, 37, 37),
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                    TextFormField(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 69, 161, 236),
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 53, 53, 53),
                        ),
                      ),
                      onChanged: (text) => {
                        setState(() => {
                          advertName = text
                        })
                      },
                    ),
                    const SizedBox(height: 10.0,),
                    TextFormField(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 53, 53, 53),
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
                        ),
                        labelText: "Description",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 53, 53, 53),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      minLines: 6,
                      onChanged: (text) => {
                        setState(() => {
                          advertDescription = text
                        })
                      },
                    ),
                    const SizedBox(height: 10.0,),
                    !filesSelected ?
                    ElevatedButton(
                      onPressed: () => selectFiles(),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Select Advert Files", style: TextStyle(fontSize: 17.0),),
                      ),
                    ) :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: files!.map((path) => Image.file(width: 150.0,height: 100.0,path)).toList()
                    ),
                ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Cancel", style: TextStyle(fontSize: 17.0),),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    onPressed: () => {
                      if (advertName != null && advertName != null && files!.isNotEmpty) {
                        visitLocationPage()
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Continue", style: TextStyle(fontSize: 17.0),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}