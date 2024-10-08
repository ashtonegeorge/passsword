import 'package:flutter/material.dart';
import 'package:passsword/add_sword_popup.dart';
import 'package:passsword/sheath_model.dart';
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
      sheathId: -1,
    );
  }
  
  void _refreshSwords() {
    setState(() {
      _swordsFuture = DatabaseHelper().getSwords();
    });
  }

  void _updateSword(Sword updatedSword) {
    setState(() {
      selectedSword = updatedSword;
      _swordsFuture = DatabaseHelper().getSwords();
    });
  }

  void _showDetails(Sword s) async {
    setState(() {
      selectedSword = s;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SwordDetailsPopup(
          sword: selectedSword,
          onUpdate: _updateSword,
        );
      },
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Swords'),
        automaticallyImplyLeading: true,
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
                return FutureBuilder<Sheath?>(
                  future: (sword.sheathId != -1) ? DatabaseHelper().getSheathById(sword.sheathId!) : Future.value(null),
                  builder: (context, sheathSnapshot) {
                    String sheathName = "None";
                    if (sheathSnapshot.connectionState == ConnectionState.waiting) {
                      sheathName = "Loading...";
                    } else if (sheathSnapshot.hasError) {
                      sheathName = "Error";
                    } else if (sheathSnapshot.hasData && sheathSnapshot.data != null) {
                      sheathName = sheathSnapshot.data!.name;
                    }
                    return ListTile(
                      title: Text(sword.name),
                      leading: (sword.type == 'Login')
                          ? const Icon(Icons.login)
                          : (sword.type == 'Security Phrase')
                              ? const Icon(Icons.security)
                              : const Icon(Icons.help),
                      subtitle: Text('Type: ${sword.type}, Sheath: $sheathName'),
                      trailing: IconButton(
                        onPressed: () async { 
                          DatabaseHelper().deleteSword(sword.id!);
                          _refreshSwords();
                        },
                        icon: const Icon(Icons.delete)
                      ),
                      onTap: () async { 
                        _showDetails(sword);
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
          List<Sheath> sheathes = await DatabaseHelper().getSheathes();
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddSwordPopup(
                initialType: 'Login',
                onTypeSelected: (String newType) {},
                sheathes: sheathes,
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