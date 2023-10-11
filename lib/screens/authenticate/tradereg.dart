import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oddjobs/services/database.dart';

class TradesmanRegister extends StatefulWidget {
  const TradesmanRegister({super.key});

  @override
  State<TradesmanRegister> createState() => _TradesmanRegisterState();
}

class _TradesmanRegisterState extends State<TradesmanRegister> {
  @override
  final _controllerName = TextEditingController();
  final _controllerAbout = TextEditingController();
  final _controllerTag = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerLocation = TextEditingController();
  final _controllerCoordinates = TextEditingController();

  String searchTermName = "";
  String searchTermAbout = "";
  String searchTermTag = "";
  String searchTermPhone = "";
  String searchTermLocation = "";
  String searchTermCoordinates = "";

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Register OddJobs Info"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controllerName,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: "Enter your name"),
              validator: (val) => val!.isEmpty ? "Enter A search term" : null,
              onChanged: (val) {
                setState(() => searchTermName = val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controllerAbout,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work),
                  hintText: "Profession"),
              validator: (val) => val!.isEmpty ? "Enter A search term" : null,
              onChanged: (val) async {
                setState(() => searchTermAbout = val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controllerTag,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.handyman_sharp),
                  hintText: "enter you skillsets separated by a ,"),
              validator: (val) => val!.isEmpty ? "Enter A search term" : null,
              onChanged: (val) async {
                setState(() => searchTermTag = val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controllerPhone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone"),
              validator: (val) => val!.isEmpty ? "Enter A search term" : null,
              onChanged: (val) async {
                setState(() => searchTermPhone = val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controllerLocation,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map),
                  hintText: "Location"),
              validator: (val) => val!.isEmpty ? "Enter A search term" : null,
              onChanged: (val) async {
                setState(() => searchTermLocation = val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controllerCoordinates,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.maps_ugc_outlined),
                  hintText:
                      "Enter your coordinates(use the previous screen to get location)"),
              validator: (val) => val!.isEmpty ? "Enter A search term" : null,
              onChanged: (val) async {
                setState(() => searchTermCoordinates = val);
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextButton.icon(
              onPressed: () async {
                final uid = await FirebaseAuth.instance.currentUser?.uid;
                await DatabaseService(uid: uid!).updateUserData(
                    searchTermName,
                    searchTermAbout,
                    searchTermLocation,
                    searchTermTag.split(","),
                    searchTermCoordinates,
                    searchTermPhone);
                //  await DatabaseService(uid: user!.uid).updateUserData(
                //      '0', 'new crew', 'perunna', ['mech', 'civil'], '120,320');
              },
              icon: Icon(
                Icons.telegram_sharp,
                size: 50,
              ),
              label: Text(
                "Submit",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
