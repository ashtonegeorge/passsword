import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'sword_model.dart';

class AddSwordPopup extends StatefulWidget {
  final String initialType;
  final ValueChanged<String> onTypeSelected;
  final List<String> sheathes; // Add this parameter

  const AddSwordPopup({
    required this.initialType,
    required this.onTypeSelected,
    required this.sheathes, // Add this parameter
  });

  @override
  _AddSwordPopupState createState() => _AddSwordPopupState();
}

class _AddSwordPopupState extends State<AddSwordPopup> {
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
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _securityPhraseController = TextEditingController();
    _selectedSwordType = widget.initialType;
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
      type: _selectedSwordType,
      name: _nameController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      securityPhrase: _securityPhraseController.text,
      sheath: _selectedSheath ?? '',
    );
  await DatabaseHelper().insertSword(sword);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Sword'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedSwordType,
              items: const [
                DropdownMenuItem<String>(
                  value: 'Login',
                  child: Text('Login'),
                ),
                DropdownMenuItem<String>(
                  value: 'Security Phrase',
                  child: Text('Security Phrase'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSwordType = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_selectedSwordType == 'Login') ...[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ] else if (_selectedSwordType == 'Security Phrase') ...[
              TextField(
                controller: _securityPhraseController,
                decoration: const InputDecoration(
                  labelText: 'Security Phrase',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedSheath,
              items: widget.sheathes.map((sheath) {
                return DropdownMenuItem<String>(
                  value: sheath,
                  child: Text(sheath),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSheath = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Sheath',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.onTypeSelected(_selectedSwordType);
            // Use the collected form data here
            print('Selected Sword Type: $_selectedSwordType');
            print('Name: ${_nameController.text}');
            print('Description: ${_descriptionController.text}');
            print('Username: ${_usernameController.text}');
            print('Password: ${_passwordController.text}');
            print('Security Phrase: ${_securityPhraseController.text}');
            print('Sheath: $_selectedSheath');
            _saveSword();
            Navigator.of(context).pop(true);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 30, 80, 189)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(const EdgeInsets.all(12.0)),
          ),
          child: const Text('Add', style: TextStyle(fontSize: 15.0)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 30, 80, 189)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          child: const Text('Cancel', style: TextStyle(fontSize: 15.0)),
        ),
      ],
    );
  }
}