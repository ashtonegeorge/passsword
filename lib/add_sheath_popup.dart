import 'package:flutter/material.dart';
import 'package:passsword/database_helper.dart';
import 'package:passsword/sheath_model.dart';

class AddSheathPopup extends StatefulWidget {
  final String initialType;
  final ValueChanged<String> onTypeSelected;

  const AddSheathPopup({
    required this.initialType,
    required this.onTypeSelected,
  });

  @override
  _AddSheathPopupState createState() => _AddSheathPopupState();
}

class _AddSheathPopupState extends State<AddSheathPopup> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late String _selectedSheathType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedSheathType = widget.initialType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveSheath() async {
    final sheath = Sheath(
      name: _nameController.text.isNotEmpty ? _nameController.text : 'Unnamed', // Provide a default value
    );
    await DatabaseHelper().insertSheath(sheath);
    widget.onTypeSelected(_selectedSheathType);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Sheath'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _saveSheath,
          child: const Text('Save'),
        ),
      ],
    );
  }
}