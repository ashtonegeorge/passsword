import 'package:flutter/material.dart';
import 'swords_page.dart';

// TODO: 
// Increase padding around the alert dialogue
// Store the swords somewhere in local storage
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 25, 48, 150)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget _selectedPage;

  @override
  void initState() {
    super.initState();
    _selectedPage = SwordsPage(); // Set the default page here
  }

  void _navigateToPage(Widget page) {
    setState(() {
      _selectedPage = page;
    });
  }

    void _addSwordPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Sword'),
          content: const Padding(padding: EdgeInsets.all(8.0), child:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.grey[400],
        
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("PassSword"),
        actions: [
          Padding(padding: const EdgeInsets.all(10.0),
          child: 
            TextButton.icon(
              onPressed: () => _addSwordPopup(context),
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
                    leading: Padding(
                      padding: EdgeInsets.all(8.5),
                      child: Icon(Icons.password_sharp),
                    ),
                    title: Text('Swords'),
                    onTap: () {
                      _navigateToPage(SwordsPage());
                    },
                  ),
                  ExpansionTile(
                    leading: IconButton(onPressed: () => print("add"), icon: const Icon(Icons.add)),
                    title: const Text('Sheathes'),
                    children: <Widget>[
                      
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
