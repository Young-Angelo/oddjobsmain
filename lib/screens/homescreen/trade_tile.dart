import 'package:flutter/material.dart';
import 'package:oddjobs/models/tradesmen.dart';

class TradeTile extends StatelessWidget {
  final TradesmenModel trade;

  TradeTile({required this.trade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue,
          ),
          title: Text(trade.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description: ${trade.description}'),
              Text(
                  'Location: ${trade.latlong}'), // Assuming location is a property in TradesmenModel
              Text(
                  'Tags: ${trade.tags.join(', ')}'), // Assuming tags is a List<String> in TradesmenModel

              Text("Phone: ${trade.phone}")
            ],
          ),
        ),
      ),
    );
  }
}
