import 'package:flutter/material.dart';
import 'package:oddjobs/models/tradesmen.dart';

class TradeTile extends StatelessWidget {
  final TradesmenModel trade;

  TradeTile({required this.trade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue[50],
            child: Text(trade.name[0]),
          ),
          trailing: const Icon(Icons.person),
          title: Text(trade.name),
          isThreeLine: true,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description: ${trade.description}'),
              Text(
                  'Location: ${trade.location}'), // Assuming location is a property in TradesmenModel
              Text(
                'Specialized: ${trade.tags.join(', ')}',
                style: TextStyle(color: Colors.red),
              ), // Assuming tags is a List<String> in TradesmenModel

              Text("Phone: ${trade.phone}"),
            ],
          ),
        ),
      ),
    );
  }
}
