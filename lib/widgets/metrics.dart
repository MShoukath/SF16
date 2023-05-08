import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.route_outlined),
                  Text('${(widget.fuelLeft * 25).round()}Km',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              Text('Estimated Range'),
              SizedBox(height: 5),
            ]),
            Column(children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.local_gas_station_outlined),
                  FutureBuilder(
                      future: Firebase.initializeApp(),
                      builder: ((BuildContext context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasError) {
                          return Text("Error");
                        } else if (snapshot.hasData) {
                          return Text(
                            "${widget.fuelLeft} L",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.fuelColor),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      })),
                ],
              ),
              const Text(
                'Fuel Level',
              ),
              SizedBox(height: 5),
            ])
          ],
        ),
      ),
    );
  }
}
