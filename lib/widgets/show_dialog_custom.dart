import 'package:flutter/material.dart';

class ShowDialogCustom{
  static Future<void> showDialogCustom(
      BuildContext context,
      String title,
      List<String> content,
      String selectedItem,
      ValueSetter<String> onItemSelected) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: content.length,
              itemBuilder: (BuildContext context, int index) {
                final String selectedContent = content[index];
                return ListTile(
                  title: Text(selectedContent),
                  selected: selectedItem == selectedContent,
                  selectedColor: Colors.green[700],
                  onTap: () {
                    onItemSelected(selectedContent);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel·lar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}