import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageSelectorBox extends StatefulWidget {
  final Function(File?) onSelectImage;
  final File? imageFile;

  const ImageSelectorBox({
    Key? key,
    required this.onSelectImage,
    this.imageFile,
  }) : super(key: key);

  @override
  _ImageSelectorBoxState createState() => _ImageSelectorBoxState();
}

class _ImageSelectorBoxState extends State<ImageSelectorBox> {
  
  @override
  Widget build(BuildContext context) {
        bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color buttonTextColor = isDarkTheme ? Colors.grey : Color.fromARGB(255, 54, 53, 53);
    Color iconColor = isDarkTheme ? Colors.green : Colors.green;
    
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _showImagePicker(context);
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                color: isDarkTheme ? Color.fromARGB(255, 54, 53, 53) : Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDarkTheme ? Color.fromARGB(255, 54, 53, 53):Colors.grey, // Цвет границы
                  width: 1.0,          // Ширина границы
                ),
            ),
            child: Center(
              child: widget.imageFile != null
                  ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.file(
                widget.imageFile!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                  : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                "assets/icons/camera.png",
                color: iconColor,
                width: 80,
                height: 80,
              ),
            ),
            ),
          ),
        ),
        if (widget.imageFile != null) ...[
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onSelectImage(null);
                },
                  style: ElevatedButton.styleFrom(
                  
      backgroundColor:  iconColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
                child: Text('Отменить',style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagePreviewScreen(imageFile: widget.imageFile!),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  
              backgroundColor:  iconColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
                child: Text('Предпросмотр',style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Сделать фото'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Выбрать из галереи'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onSelectImage(File(pickedFile.path));
    }
  }

  void _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      widget.onSelectImage(File(pickedFile.path));
    }
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;

  const ImagePreviewScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Предпросмотр'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}