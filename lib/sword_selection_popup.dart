// sword_selection_popup.dart
import 'package:flutter/material.dart';

class SwordSelectionPopup extends StatefulWidget {
  final String initialType;
  final ValueChanged<String> onTypeSelected;

  SwordSelectionPopup({required this.initialType, required this.onTypeSelected});

  @override
  _SwordSelectionPopupState createState() => _SwordSelectionPopupState();
}

class _SwordSelectionPopupState extends State<SwordSelectionPopup> {
  late String _selectedSwordType;

  @override
  void initState() {
    super.initState();
    _selectedSwordType = widget.initialType;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(padding: const EdgeInsets.all(50.0),
          child: Column( // main column
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: <Widget>[
                const Text("Add Sword", // title
                  style: TextStyle(fontSize: 30.0), 
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16.0), // Add vertical spacing
                const Row( // name and description row
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( // name
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter sword name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0), // Add horizontal spacing between the text fields
                    Expanded( // description
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter sword description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0), // Add vertical spacing
                Row( // type and sheath row
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( // type
                      child: DropdownButtonFormField<String>(
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
                            print(_selectedSwordType);
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0), // Add horizontal spacing between the text fields
                    Expanded( // sheath
                      child: DropdownButtonFormField<String>(
                        value: 'None', // default value
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'None',
                            child: Text('None'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          // Handle the change
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Sheath',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
                if(_selectedSwordType == 'Login') ...[
                  const SizedBox(height: 16.0), // Add vertical spacing
                  const Row( // name and description row
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded( // name
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0), // Add horizontal spacing between the text fields
                      Expanded( // description
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16.0), // Add vertical spacing
                Row( // add and dismiss buttons
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton( // add button
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 30, 80, 189)),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        padding: WidgetStatePropertyAll(EdgeInsets.all(12.0)),
                    ),
                      child: const Text('Add', style: TextStyle(fontSize: 15.0),),
                    ),
                    const SizedBox(width: 16.0), // Add horizontal spacing between the text fields
                    TextButton( // dismiss button
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 30, 80, 189)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          padding: WidgetStatePropertyAll(EdgeInsets.all(12.0)),
                      ),
                      child: const Text('Dismiss', style: TextStyle(fontSize: 15.0),),
                    ),
                  ],
                )
              ],
            ),
        )
      )
    );
  }
}