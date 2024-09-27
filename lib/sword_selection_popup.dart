// // sword_selection_popup.dart
// import 'package:flutter/material.dart';

// class SwordSelectionPopup extends StatefulWidget {
//   final String initialType;
//   final ValueChanged<String> onTypeSelected;

//   SwordSelectionPopup({required this.initialType, required this.onTypeSelected});

//   @override
//   _SwordSelectionPopupState createState() => _SwordSelectionPopupState();
// }

// class _SwordSelectionPopupState extends State<SwordSelectionPopup> {
//   late String _selectedSwordType;
//   late TextEditingController _nameController, _descriptionController, _usernameController, _passwordController, _securityPhraseController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _descriptionController = TextEditingController();
//     _usernameController = TextEditingController();
//     _passwordController = TextEditingController();
//     _securityPhraseController = TextEditingController();
//     _selectedSwordType = widget.initialType;
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _usernameController.dispose();
//     _passwordController.dispose();
//     _securityPhraseController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.6,
//         height: MediaQuery.of(context).size.height * 0.6,
//         child: Padding(padding: const EdgeInsets.all(50.0),
//           child: Column( // main column
//               crossAxisAlignment: CrossAxisAlignment.start, 
//               children: <Widget>[
//                 const Text("Add Sword", // title
//                   style: TextStyle(fontSize: 30.0), 
//                   textAlign: TextAlign.left,
//                 ),
//                 const SizedBox(height: 16.0), // Add vertical spacing
//                 const Row( // name and description row
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded( // name
//                       child: TextField(
//                         decoration: InputDecoration(
//                           labelText: 'Name',
//                           hintText: 'Enter sword name',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16.0), // Add horizontal spacing between the text fields
//                     Expanded( // description
//                       child: TextField(
//                         decoration: InputDecoration(
//                           labelText: 'Description',
//                           hintText: 'Enter sword description',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16.0), // Add vertical spacing
//                 Row( // type and sheath row
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded( // type
//                       child: DropdownButtonFormField<String>(
//                         value: _selectedSwordType,
//                         items: const [
//                           DropdownMenuItem<String>(
//                             value: 'Login',
//                             child: Text('Login'),
//                           ),
//                           DropdownMenuItem<String>(
//                             value: 'Security Phrase',
//                             child: Text('Security Phrase'),
//                           ),
//                         ],
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _selectedSwordType = newValue!;
//                           });
//                         },
//                         decoration: const InputDecoration(
//                           labelText: 'Select Type',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16.0), // Add horizontal spacing between the text fields
//                     Expanded( // sheath
//                       child: DropdownButtonFormField<String>(
//                         value: 'None', // default value
//                         items: const [
//                           DropdownMenuItem<String>(
//                             value: 'None',
//                             child: Text('None'),
//                           ),
//                         ],
//                         onChanged: (String? newValue) {

//                         },
//                         decoration: const InputDecoration(
//                           labelText: 'Select Sheath',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]
//                 ),
//                 if(_selectedSwordType == 'Login') ...[
//                   const SizedBox(height: 16.0), // Add vertical spacing
//                   const Row( // name and description row
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded( // name
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText: 'Username',
//                             hintText: 'Enter username',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 16.0), // Add horizontal spacing between the text fields
//                       Expanded( // description
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             hintText: 'Enter password',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//                 const SizedBox(height: 16.0), // Add vertical spacing
//                 Row( // add and dismiss buttons
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     TextButton( // add button
//                       onPressed: () {
//                         widget.onTypeSelected(_selectedSwordType);
//                         // Use the collected form data here
//                         print('Selected Sword Type: $_selectedSwordType');
//                         print('Name: ${_nameController.text}');
//                         print('Description: ${_descriptionController.text}');
//                         print('Username: ${_usernameController.text}');
//                         print('Password: ${_passwordController.text}');
//                         print('Security Phrase: ${_securityPhraseController.text}');
//                         Navigator.of(context).pop();
//                       },
//                     style: const ButtonStyle(
//                         backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 30, 80, 189)),
//                         foregroundColor: WidgetStatePropertyAll(Colors.white),
//                         padding: WidgetStatePropertyAll(EdgeInsets.all(12.0)),
//                     ),
//                       child: const Text('Add', style: TextStyle(fontSize: 15.0),),
//                     ),
//                     const SizedBox(width: 16.0), // Add horizontal spacing between the text fields
//                     TextButton( // dismiss button
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       style: const ButtonStyle(
//                           backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 30, 80, 189)),
//                           foregroundColor: WidgetStatePropertyAll(Colors.white),
//                           padding: WidgetStatePropertyAll(EdgeInsets.all(12.0)),
//                       ),
//                       child: const Text('Dismiss', style: TextStyle(fontSize: 15.0),),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//         )
//       ),
//     );
//   }
// }

// sword_selection_popup.dart
import 'package:flutter/material.dart';

class SwordSelectionPopup extends StatefulWidget {
  final String initialType;
  final ValueChanged<String> onTypeSelected;
  final List<String> sheathes; // Add this parameter

  SwordSelectionPopup({
    required this.initialType,
    required this.onTypeSelected,
    required this.sheathes, // Add this parameter
  });

  @override
  _SwordSelectionPopupState createState() => _SwordSelectionPopupState();
}

class _SwordSelectionPopupState extends State<SwordSelectionPopup> {
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Sword Type'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
                labelText: 'Select Sheath Type',
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
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 80, 189)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(EdgeInsets.all(12.0)),
          ),
          child: const Text('Add', style: TextStyle(fontSize: 15.0)),
        ),
        const SizedBox(width: 16.0), // Add horizontal spacing between the text fields
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 80, 189)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: const Text('Dismiss', style: TextStyle(fontSize: 15.0)),
        ),
      ],
    );
  }
}