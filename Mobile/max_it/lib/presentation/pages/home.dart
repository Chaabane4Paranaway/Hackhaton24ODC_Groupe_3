import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:max_it/core/constants/sizedbox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      body: SafeArea(
          top: false,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.paddingOf(context).top),
                  Row(
                    children: [
                      const SizedBox(
                          height: 40, width: 40, child: Placeholder()),
                      8.h,
                      const Text("09090909"),
                      8.h,
                      const Icon(Icons.arrow_drop_down),
                      const Spacer(),
                      const SizedBox(
                          height: 40, width: 40, child: Placeholder()),
                    ],
                  ),
                  32.v,
                  Row(
                    children: [
                      const Text(
                        "Bonjour Chaabane DS",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      4.h,
                      const SizedBox(
                          height: 20, width: 20, child: Placeholder()),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (cotext, index) {
                          return const Padding(
                            padding: EdgeInsets.only(right: 24),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.orange,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 36, 36, 36),
                        ),
                      ),
                      20.v,
                      Row(
                        children: [
                          const Text("Mes favoris",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text("Mes favoris",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    color: Colors.orange,
                                  )
                                ],
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
      backgroundColor: Colors.black,
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          elevation: 4,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      SizedBox(height: 30, width: 30, child: Placeholder()),
                      Text("Orange Money",
                          style: TextStyle(
                            fontSize: 13,
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.sim_card,
                        size: 30,
                      ),
                      Expanded(
                        child: Text("Ma Ligne",
                            style: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      Expanded(
                        child: Text("Marketplace",
                            style: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.qr_code,
                        size: 30,
                      ),
                      Expanded(
                        child: Text("Codes QR",
                            style: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
