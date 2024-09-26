import 'package:flutter/material.dart';
import 'package:passsword/sword_selection_popup.dart';
import 'swords_page.dart';

// TODO: 
// Store the swords somewhere in local storage - UTILIZE HIVE NO SQL DATABASE
// present the data in the swords page
// create a sheathes dialogue box and dynamic pages
// implement encryption and decryption

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget _selectedPage;
  late String _selectedSwordType;

  @override
  void initState() {
    super.initState();
    _selectedPage = const SwordsPage(); // Set the default page
    _selectedSwordType = "Login"; // Set the default sword type
  }

  void _navigateToPage(Widget page) {
    setState(() {
      _selectedPage = page;
    });
  }

  void _showSwordPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SwordSelectionPopup(
          initialType: _selectedSwordType,
          onTypeSelected: (String newType) {
            setState(() {
              _selectedSwordType = newType;
            });
            print(_selectedSwordType); // Print the selected sword type
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("PassSword"),
        actions: [
          Padding(padding: const EdgeInsets.all(10.0),
          child: 
            TextButton.icon(
              onPressed: _showSwordPopup,
              icon: const Icon(Icons.add),
              label: const Text("Add Sword"),
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 30, 80, 189)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
            ),
          ),
        ],
      ),

      body: Row(
        children: <Widget>[
          Flexible(
            flex: 1, // Adjust this value to control the width proportion
            child: Container(
              color: Colors.grey[200],
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.all(8.5),
                      child: Icon(Icons.password_sharp),
                    ),
                    title: const Text('Swords'),
                    onTap: () {
                      _navigateToPage(SwordsPage());
                    },
                  ),
                  ExpansionTile(
                    leading: IconButton(onPressed: () => print("add"), icon: const Icon(Icons.add)),
                    title: const Text('Sheathes'),
                    children: const <Widget>[
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3, // Adjust this value to control the width proportion
            child: _selectedPage,
          ),
        ],
      ),
    );
  }
}
