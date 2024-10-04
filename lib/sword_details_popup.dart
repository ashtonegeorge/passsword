import 'package:passsword/sword_model.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';

class SwordDetailsPopup extends StatefulWidget {
  final Sword sword;

  const SwordDetailsPopup({required this.sword});

  @override
  _SwordDetailsPopupState createState() => _SwordDetailsPopupState();
}

class _SwordDetailsPopupState extends State<SwordDetailsPopup> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _securityPhraseController;
  late String _selectedSwordType;
  String? _selectedSheath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sword.name);
    _usernameController = TextEditingController(text: widget.sword.username);
    _passwordController = TextEditingController(text: widget.sword.password);
    _securityPhraseController = TextEditingController(text: widget.sword.securityPhrase);
    _selectedSwordType = widget.sword.type;
    _selectedSheath = widget.sword.sheath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _securityPhraseController.dispose();
    super.dispose();
  }

  Future<void> _saveSword() async {
    final sword = Sword(
      id: widget.sword.id,
      type: _selectedSwordType,
      name: _nameController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      securityPhrase: _securityPhraseController.text,
      sheath: _selectedSheath ?? '',
    );
    await DatabaseHelper().updateSword(sword);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sword Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: _selectedSwordType,
              items: <String>['Katana', 'Broadsword', 'Rapier', 'Scimitar']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedSwordType = value!;
                });
              },
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: _securityPhraseController,
              decoration: const InputDecoration(labelText: 'Security Phrase'),
            ),
            DropdownButton<String>(
              value: _selectedSheath,
              items: <String>['Sheath 1', 'Sheath 2', 'Sheath 3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedSheath = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await _saveSword();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}