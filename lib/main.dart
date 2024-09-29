import 'package:flutter/material.dart';
import 'dart:io';
import 'package:passsword/add_sword_popup.dart';
import 'package:passsword/database_helper.dart';
import 'swords_page.dart';
import 'package:path/path.dart' as p; // Alias the path package import
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_ffi


// TODO: 
// present the data in the swords page
// create a sheathes dialogue box and dynamic pages
// implement encryption and decryption

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await DatabaseHelper().initDatabase();
  runApp(MyApp());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 30, 80, 189)),
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
        return AddSwordPopup(
          initialType: _selectedSwordType,
          onTypeSelected: (String newType) {
            setState(() {
              _selectedSwordType = newType;
            });
            print(_selectedSwordType); // Print the selected sword type
          },
          sheathes: [
            "Sheath 1",
            "Sheath 2",
            "Sheath 3",
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 80, 189),
        title: const Text("PassSword"),
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
                    title: const Text('All Swords'),
                    onTap: () {
                      _navigateToPage(const SwordsPage());
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
