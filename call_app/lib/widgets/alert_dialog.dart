import 'package:flutter/material.dart';

class MyDialogAlert extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const MyDialogAlert({super.key, required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _MyDialogAlertState createState() => _MyDialogAlertState();
}

class _MyDialogAlertState extends State<MyDialogAlert> {
  int? selectedStatus; // Başlangıçta seçili olan status

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sonuç'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: <Widget>[
            RadioListTile(
              title: Text('Görüşüldü'),
              value: 1,
              groupValue: selectedStatus,
              onChanged: (int? value) {
                setState(() {
                  selectedStatus = value!;
                });
                widget.onChanged(selectedStatus!);
              },
            ),
            RadioListTile(
              title: Text('Görüşülmedi'),
              value: 2,
              groupValue: selectedStatus,
              onChanged: (int? value) {
                setState(() {
                  selectedStatus = value!;
                });
                widget.onChanged(selectedStatus!);
              },
            ),
            // RadioListTile ekleyebiliriz.
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Tamam'),
          onPressed: () {
            // Seçilen status değerini kullanabilirsiniz
            print('Seçilen Status: $selectedStatus');
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
