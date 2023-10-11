import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:oddjobs/screens/authenticate/tradereg.dart';
import 'package:oddjobs/screens/homescreen/main_page.dart';
import 'package:oddjobs/services/auth.dart';
import 'package:oddjobs/location.dart';
import 'package:oddjobs/shared/loading.dart';
//import 'package:geolocator/geolocator.dart';

final AuthService _auth = AuthService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String error = " ";
  bool loading = false;
  final _controller = TextEditingController();
  String lat = "";
  String longi = "";
  String searchTerm = "";
  //String imageMap = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.brown[400],
              title: const Text("Set Location"),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TradesmanRegister()),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.handyman,
                    color: Colors.cyanAccent,
                  ),
                  label: const Text("Trades"),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.cyanAccent,
                  ),
                  label: const Text("Logout"),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                )
              ],
            ),
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(30),
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.maps_ugc_sharp),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Enter A search term" : null,
                      onChanged: (val) async {
                        setState(() => searchTerm = val);
                      },
                    )),
                TextButton.icon(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    dynamic position =
                        await getPos().whenComplete(() => loading = false);
                    setState(() {
                      lat = position.latitude.toString();
                      longi = position.longitude.toString();
                    });

                    _controller.text = "$lat,$longi";

                    //print(Lat);
                  },
                  icon: const Icon(Icons.map),
                  label: const Text("Get Location"),
                ),
                TextButton.icon(
                    onPressed: () {
                      setState(() {
                        error = "";
                      });
                      if (lat.isNotEmpty) {
                        try {
                          MapsLauncher.launchCoordinates(
                              double.parse(lat), double.parse(longi));
                        } catch (e) {
                          error = "Please enter";
                          print("sup");
                        }
                        setState(() {
                          lat = "";
                          longi = "";
                        });
                      } else {
                        if (_controller.text.isNotEmpty) {
                          //print(_controller.text);
                          MapsLauncher.launchQuery(_controller.text);
                        } else {
                          setState(() => error = "Please enter");
                          //print("nonono");
                        }
                      }
                    },
                    icon: const Icon(Icons.maps_ugc_rounded),
                    label: const Text("Open Maps")),
                Container(
                  //   padding: const EdgeInsets.all(60),
                  //  margin: const EdgeInsets.all(60),
                  child: Text(error, style: const TextStyle(color: Colors.red)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: const Image(image: AssetImage('assets/maps.png')),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blue),
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton.outlined(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchJob(
                                    latlong: _controller.text,
                                  )),
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    iconSize: 70,
                    color: Colors.blue,
                  ),
                ))
              ],
            ));
  }
}
