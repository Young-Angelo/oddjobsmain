import 'package:flutter/material.dart';
import 'package:oddjobs/models/tradesmen.dart';
import 'package:oddjobs/screens/homescreen/tradeslist.dart';
import 'package:oddjobs/services/auth.dart';
import 'package:oddjobs/services/database.dart';
import 'package:provider/provider.dart';

final AuthService _auth = AuthService();

class SearchJob extends StatefulWidget {
  final String latlong;

  SearchJob({Key? key, required this.latlong}) : super(key: key);

  //const SearchJob({super.key});

  @override
  State<SearchJob> createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  final _controller = TextEditingController();

  String searchTerm = "";
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TradesmenModel>>.value(
        initialData: const [],
        value: DatabaseService(uid: "").trades,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Search"),
            actions: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.person),
                label: const Text("Logout"),
                style: TextButton.styleFrom(foregroundColor: Colors.white),
              )
            ],
          ),
          body: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(30),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search_sharp),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Enter A search term" : null,
                    onChanged: (val) async {
                      setState(() => searchTerm = val);
                    },
                  )),
              //TradeList()
              Expanded(
                  child: TradeList(
                      dataToPass: searchTerm, LatLong: widget.latlong)),
            ],
          ),
        ));
  }
}
