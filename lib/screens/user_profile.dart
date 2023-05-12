import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:smartfueling/main.dart';
import 'package:smartfueling/screens/login_screen.dart';
import 'package:smartfueling/widgets/trip.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var name = " ";
  var email = " ";
  var userid = " ";
  var mileage = "";
  var tankCapacity = "";

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Stream users = FirebaseFirestore.instance.collection('Users').snapshots();

    // users.listen((event) {
    //   var docs = event.snapshot.data!.docs;
    //   mileage = docs[0]['mileage'];
    //   print(mileage);
    // });

    if (user != null) {
      user.updateDisplayName("Karthik");
      email = user.email.toString();
      userid = user.uid;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.navigate_before),
        ),
        title: const Text("Profile"),
      ),
      body: Container(
        // height: 400,
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
            stream: users,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Connection error');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading......');
              } else {
                var docs = snapshot.data!.docs;
                mileage = docs[0]['mileage'];
                tankCapacity = docs[0]['tank_capacity'];
                return ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.account_circle_outlined),
                      title: Text('User Name : $name'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: Text('EmailID : $email'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.gas_meter_outlined),
                      title: Text('Mileage : $mileage'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.local_gas_station_outlined),
                      title: Text('Tank Capacity : $tankCapacity'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        },
                        icon: const Icon(Icons.logout_outlined),
                        label: const Text('Logout')),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        elevation: 6,
                        child: Column(children: const [
                          Text(
                            'History of Trips',
                            style: TextStyle(fontSize: 20),
                          ),
                          Trip()
                        ])),
                  ],
                );
              }
            }),
      ),
    );
  }
}
