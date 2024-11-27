import 'package:flutter/material.dart';
import 'package:max_it/core/constants/sizedbox.dart';

class ModalPinInput extends StatefulWidget {
  const ModalPinInput({
    super.key,
  });

  @override
  State<ModalPinInput> createState() => _ModalPinInputState();
}

class _ModalPinInputState extends State<ModalPinInput> {
  List<bool> pinInputStates = List.generate(4, (index) => false);
  int pos = 0;
  List<String> inputValues = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
  ];

  @override
  void initState() {
    inputValues.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          40.v,
          const Text(
            "Tapez votre code secret Orange Money",
            style: TextStyle(fontSize: 18),
          ),
          16.v,
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: pinInputStates.length,
                itemBuilder: (context, index) {
                  return PinComponent(pinInputStates[index]);
                }),
          ),
          16.v,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Nombre de colonnes
                  crossAxisSpacing:
                      10.0, // Espacement horizontal entre les colonnes
                  mainAxisSpacing:
                      10.0, // Espacement vertical entre les rangées
                ),
                itemCount: 12, // 4 colonnes * 3 rangées = 12
                itemBuilder: (context, index) {
                  if (index == 11) {
                    return GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.orange,
                          child: CircleAvatar(
                              maxRadius: 39,
                              backgroundColor: Colors.transparent,
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold),
                              ))),
                    );
                  }
                  if (index == 10) {
                    return GestureDetector(
                      onTap: () {
                        if (pos > 0) {
                          setState(() {
                            pinInputStates.insert(pos - 1, false);
                            pinInputStates.removeAt(pos);
                            pos--;
                          });
                        }
                      },
                      child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.orange,
                          child: CircleAvatar(
                            maxRadius: 39,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.delete,
                              size: 40,
                            ),
                          )),
                    );
                  } else {
                    Widget value = Text(
                      inputValues[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    );
                    return GestureDetector(
                      onTap: () {
                        if (pos < 4) {
                          setState(() {
                            pinInputStates.insert(pos, true);
                            pinInputStates.removeAt(pos + 1);
                            pos++;
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.orange,
                        child: CircleAvatar(
                          maxRadius: 42,
                          backgroundColor: Colors.white,
                          child: value,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PinComponent extends StatelessWidget {
  final bool isActive;
  const PinComponent(
    this.isActive, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CircleAvatar(
        backgroundColor: Colors.orange,
        child: isActive
            ? null
            : const CircleAvatar(
                maxRadius: 18,
                backgroundColor: Colors.white,
              ),
      ),
    );
  }
}
