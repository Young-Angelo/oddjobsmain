/* import 'package:flutter/material.dart';
import 'package:oddjobs/models/tradesmen.dart';
import 'package:oddjobs/screens/homescreen/trade_tile.dart';
import 'package:provider/provider.dart';

class TradeList extends StatefulWidget {
  // const TradeList({super.key});
  final String dataToPass;

  TradeList({Key? key, required this.dataToPass}) : super(key: key);

  @override
  State<TradeList> createState() => _TradeListState();
}

class _TradeListState extends State<TradeList> {
  @override
  Widget build(BuildContext context) {
    final trades = Provider.of<List<TradesmenModel>>(context);

    try {
      trades.forEach((trade) {
        print(trade.name);
        print(trade.description);
      });
      print(widget.dataToPass);
    } catch (e) {
      print("no");
    }

    return ListView.builder(
      itemCount: trades.length,
      itemBuilder: (context, index) {
        return TradeTile(trade: trades[index]);
      },
    );
  
  }
  
}
 */

import 'package:flutter/material.dart';
import 'package:oddjobs/models/tradesmen.dart';
import 'package:oddjobs/screens/homescreen/trade_tile.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class TradeList extends StatefulWidget {
  final String dataToPass;
  final String LatLong;

  TradeList({Key? key, required this.dataToPass, required this.LatLong})
      : super(key: key);

  @override
  State<TradeList> createState() => _TradeListState();
}

class _TradeListState extends State<TradeList> {
  @override
  Widget build(BuildContext context) {
    final trades = Provider.of<List<TradesmenModel>>(context);

    List<String> latLongList = widget.LatLong.split(',');

    double latitude = double.parse(latLongList[0]);
    double longitude = double.parse(latLongList[1]);

    final firstfilteredTrades = trades.where((trade) {
      final List<String> tradelatLong = trade.latlong.split(",");
      final double lat = double.parse(tradelatLong[0]);
      print(tradelatLong[0]);
      print(tradelatLong[1]);
      final double long = double.parse(tradelatLong[1]);

      final double distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        lat,
        long,
      );

      // Include a trade in the filtered list if it is within 20 km
      return distance < 20000; // 20 km in meters
    }).toList();
    // Filter trades based on both LatLong and dataToPass
    final filteredTrades = firstfilteredTrades.where((trade) {
      final bool matchesDataToPass = trade.tags.any((tag) =>
              tag.toLowerCase().contains(widget.dataToPass.toLowerCase())) ||
          trade.description
              .toLowerCase()
              .contains(widget.dataToPass.toLowerCase());

      // Include a trade in the filtered list if it matches the condition
      return matchesDataToPass;
    }).toList();

    try {
      filteredTrades.forEach((trade) {
        print(trade.name);
        print(trade.description);
      });
      print(widget.dataToPass);
    } catch (e) {
      print("no");
    }

    return ListView.builder(
      itemCount: filteredTrades.length,
      itemBuilder: (context, index) {
        return TradeTile(trade: filteredTrades[index]);
      },
    );
  }
}
