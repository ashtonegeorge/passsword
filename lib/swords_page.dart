import 'package:flutter/material.dart';
import 'package:passsword/add_sword_popup.dart';
import 'package:passsword/sword_details_popup.dart';
import 'database_helper.dart';
import 'sword_model.dart';

class SwordsPage extends StatefulWidget {
  const SwordsPage({super.key});

  @override
  _SwordsPageState createState() => _SwordsPageState();
}

class _SwordsPageState extends State<SwordsPage> {
  late Future<List<Sword>> _swordsFuture;
  late Sword selectedSword;

  @override
  void initState() {
    super.initState();
    _swordsFuture = DatabaseHelper().getSwords();
    selectedSword = Sword(
      id: -1,
      type: '',
      name: '',
      username: '',
      password: '',
      securityPhrase: '',
      sheath: '',
    );
  }
  
  void _refreshSwords() {
    setState(() {
      _swordsFuture = DatabaseHelper().getSwords();
    });
  }

  void _showDetails(Sword s) async {
    setState(() {
      selectedSword = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Swords'),
        automaticallyImplyLeading: false,
        
      ),
      body: FutureBuilder<List<Sword>>(
        future: _swordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No swords available'));
          } else {
            final swords = snapshot.data!;
            return ListView.builder(
              itemCount: swords.length,
              itemBuilder: (context, index) {
                final sword = swords[index];
                return ListTile(
                  title: Text(sword.name),
                  leading: (sword.type == 'Login')
                      ? const Icon(Icons.login)
                      : (sword.type == 'Security Phrase')
                          ? const Icon(Icons.security)
                          : const Icon(Icons.help),

                  subtitle: Text('Type: ${sword.type}, Sheath: ${sword.sheath}'),
                  trailing: IconButton(
                    onPressed: () async { 
                      DatabaseHelper().deleteSword(sword.id!);
                      _refreshSwords();
                      },
                    icon: const Icon(Icons.delete)
                  ),
                  onTap: () async { 
                    _showDetails(sword);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SwordDetailsPopup(
                          sword: selectedSword,
                        );
                      },
                    ); 
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddSwordPopup(
                initialType: 'Login',
                onTypeSelected: (String newType) {},
                sheathes: ['one', 'two', 'three'],
              );
            },
          );
          if (result == true) {
            _refreshSwords();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Sword"),
        backgroundColor: const Color.fromARGB(255, 30, 80, 189),
        foregroundColor: Colors.white,
      ),
    );
  }
}