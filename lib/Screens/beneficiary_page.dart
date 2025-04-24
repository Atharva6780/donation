import 'package:flutter/material.dart';

class BeneficiaryPage extends StatefulWidget {
  const BeneficiaryPage({Key? key}) : super(key: key);

  @override
  State<BeneficiaryPage> createState() => _BeneficiaryPageState();
}

class _BeneficiaryPageState extends State<BeneficiaryPage> {
  List<String> beneficiaries = [
    'Rahul Sharma',
    'Priya Verma',
    'Amit Singh',
    'Neha Patel'
  ];

  void _addBeneficiary(String name) {
    setState(() {
      beneficiaries.add(name);
    });
  }

  void _showAddDialog() {
    String newName = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Beneficiary"),
        content: TextField(
          onChanged: (value) => newName = value,
          decoration: const InputDecoration(hintText: "Enter beneficiary name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (newName.trim().isNotEmpty) {
                _addBeneficiary(newName.trim());
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beneficiaries"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: beneficiaries.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.person, color: Colors.red),
          title: Text(beneficiaries[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
