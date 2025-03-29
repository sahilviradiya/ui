import 'package:flutter/material.dart';
import 'package:ui/theme/color/colors.dart';

class EditCaptionScreen extends StatefulWidget {
  final String caption;
  final Function(String) onSave;

  const EditCaptionScreen({required this.caption, required this.onSave, Key? key}) : super(key: key);

  @override
  _EditCaptionScreenState createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  late TextEditingController _controller;
  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.caption);
    _controller.addListener(() {
      setState(() {
        _isEdited = _controller.text != widget.caption;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Caption", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: _isEdited
                  ? () {
                widget.onSave(_controller.text);
                Navigator.pop(context);
              }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: _isEdited ? Colors.green : customGreen,
                  borderRadius: BorderRadius.circular(70),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: _isEdited ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
