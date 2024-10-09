import 'package:flutter/material.dart';
import 'package:passsword/sheath_model.dart';
import 'database_helper.dart';
import 'sword_model.dart';

class AddSwordPopup extends StatefulWidget {
  final String initialType;
  final ValueChanged<String> onTypeSelected;
  final List<Sheath> sheathes; 

  const AddSwordPopup({
    required this.initialType,
    required this.onTypeSelected,
    required this.sheathes,
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
  int? _selectedSheathId = 0;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _securityPhraseController = TextEditingController();
    _selectedSwordType = widget.initialType;

    widget.sheathes.insert(0, Sheath(id: 0, name: 'None'));
    _selectedSheathId = 0;
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
      name: _nameController.text.isNotEmpty ? _nameController.text : 'Unnamed', // Provide a default value
      username: _usernameController.text.isNotEmpty ? _usernameController.text : 'Unknown', // Provide a default value
      password: _passwordController.text.isNotEmpty ? _passwordController.text : 'Unknown', // Provide a default value
      securityPhrase: _securityPhraseController.text.isNotEmpty ? _securityPhraseController.text : 'None', // Provide a default value
      sheathId: _selectedSheathId ?? 0, // Ensure sheathId is not null
    );
    if (sword.id == null) {
      // Handle the case where the id is null (e.g., insert a new record)
      await DatabaseHelper().insertSword(sword.toMap());
    } else {
      await DatabaseHelper().updateSword(sword);
    }
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: 
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: (_obscureText) ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ],
              )
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
            DropdownButtonFormField<int>(
              value: _selectedSheathId,
              items: widget.sheathes.map((sheath) {
                return DropdownMenuItem<int>(
                  value: sheath.id,
                  child: Text(sheath.name),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedSheathId = newValue!;
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