import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Trip extends StatefulWidget {
  const Trip({super.key});

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  final userStream = FirebaseFirestore.instance.collection("Trips").snapshots();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: StreamBuilder(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Connection error');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading......');
            } else {
              var docs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(docs[index]['route']),
                      subtitle: Text(docs[index]['mileage']),
                    );
                  });
            }
          }),
    );
    // );
  }
}
