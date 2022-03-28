import 'package:flutter/material.dart';

class ProfilUserCard extends StatefulWidget {
  const ProfilUserCard({Key? key}) : super(key: key);

  @override
  State<ProfilUserCard> createState() => _ProfilUserCardState();
}

class _ProfilUserCardState extends State<ProfilUserCard> {
  bool seeUpdate = false;

  /// affiche/cache volet update user
  void openCloseUpdated() {
    setState(() {
      seeUpdate = !seeUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        children: [
          
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              'Nom : ',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              'Prénom : ',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              'Pseudo : ',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              'Email : ',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
