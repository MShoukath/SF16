import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Metrics extends StatefulWidget {
  late final double fuelLeft;
  late final Color fuelColor;
  Metrics({super.key, required this.fuelLeft, required this.fuelColor});

  @override
  State<Metrics> createState() => _MetricsState();
}

class _MetricsState extends State<Metrics> {
  // String fuelLeft = '0';

  // Color color = Colors.black;
  int mileage = 0;
  int range = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.route_outlined),
                  Text('${(widget.fuelLeft * 25).round()}Km',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              const Text('Estimated Range'),
              const SizedBox(height: 5),
            ]),
            Column(children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.local_gas_station_outlined),
                  FutureBuilder(
                      future: Firebase.initializeApp(),
                      builder: ((BuildContext context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasError) {
                          return const Text("Error");
                        } else if (snapshot.hasData) {
                          return Text(
                            "${widget.fuelLeft} L",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.fuelColor),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })),
                ],
              ),
              const Text(
                'Fuel Level',
              ),
              const SizedBox(height: 5),
            ])
          ],
        ),
      ),
    );
  }
}
