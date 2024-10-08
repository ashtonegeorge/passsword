import 'package:passsword/sword_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';

class SwordDetailsPopup extends StatefulWidget {
  final Sword sword;
  final Function(Sword) onUpdate;

  const SwordDetailsPopup({required this.sword, required this.onUpdate});

  @override
  _SwordDetailsPopupState createState() => _SwordDetailsPopupState();
}

class _SwordDetailsPopupState extends State<SwordDetailsPopup> {
  late Sword _sword;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  late TextEditingController _securityPhraseController;
  late String _selectedSwordType;
  int? _selectedSheathId;
  bool _obscureText = true;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _sword = widget.sword;
    _nameController = TextEditingController(text: _sword.name);
    _usernameController = TextEditingController(text: _sword.username);
    _passwordController = TextEditingController(text: _sword.password);
    _securityPhraseController = TextEditingController(text: _sword.securityPhrase);
    _selectedSwordType = _sword.type;
    _selectedSheathId = _sword.sheathId;
  }

  @override
  void dispose() {
    _nameController.dispose();
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
      sheathId: _selectedSheathId ?? -1,
    );
    await DatabaseHelper().updateSword(sword);
    widget.onUpdate(_sword);
    setState(() {
      _sword = sword;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_nameController.text),
      content: SingleChildScrollView(
        child: (_sword.type == 'Login') ? Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: !_editing,
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _usernameController.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Username copied to clipboard')),
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: !_editing,
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: _obscureText,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _passwordController.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password copied to clipboard')),
                    );
                  },
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
            ),
          ],
        ) : Column (
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: !_editing,
                    controller: _securityPhraseController,
                    decoration: InputDecoration(labelText: _sword.name),
                  ), 
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _securityPhraseController.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Security Phrase copied to clipboard')),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        if (!_editing)
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _editing = true;
                    });
                  },
                  child: Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Done'),
                ),
              ],
            ),
          )
        else
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () async {
                    await _saveSword();
                    setState(() {
                      _editing = false;
                    });
                  },
                  child: const Text('Save'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}