import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<DropdownMenuItem<String>> lastNameList = [
    const DropdownMenuItem<String>(
      value: "",
      child: Text("-"),
    ),
    const DropdownMenuItem<String>(
      value: "NACRO",
      child: Text("NACRO"),
    ),
    const DropdownMenuItem<String>(
      value: "YARO",
      child: Text("YARO"),
    ),
    const DropdownMenuItem<String>(
      value: "KOURAOGO",
      child: Text("KOURAOGO"),
    ),
    const DropdownMenuItem<String>(
      value: "SAWADOGO",
      child: Text("SAWADOGO"),
    ),
    const DropdownMenuItem<String>(
      value: "SIMPORE",
      child: Text("SIMPORE"),
    ),
  ];
  String? actualLastName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Débloquer mon compte"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.orange,
                  //isExpanded: true,
                  hint: const Text("Sélectionner votre nom"),
                  value: actualLastName,
                  items: lastNameList,
                  onChanged: (String? newvalue) {
                    setState(() {  u§«kl;o÷÷÷, jnnfbn
                    
                      actualLastName 
                    });U
                  }),
            ], 
          ),
        ),
      )),
    );
  }
}
