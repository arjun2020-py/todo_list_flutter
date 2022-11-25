import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final userRef = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 193, 139),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 90),
          child: Text(
            'Profile',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: userRef.doc(auth.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!;
              print(userData);

              //cloumn wrap with streambuilder
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      'My Account',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Card(
                        color: Colors.white54,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: (userData['profileImage'] == '')
                                ? Text(
                                    userData['userName'][0]
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                    // ignore: lines_longer_than_80_chars
                                  )
                                : ClipOval(
                                    child: Image.network(
                                      userData['profileImage'].toString(),
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                          ),
                          title: Text(
                            userData['userName'].toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            userData['email'].toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: getImage,
                            child: Text('Upload Pic'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      child: ListTile(
                        leading: const Text('My Task'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Card(
                      child: ListTile(
                        leading: const Text('Task Done'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Card(
                      child: ListTile(
                        leading: const Text('Pending Task'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Card(
                      child: ListTile(
                        leading: const Text('Address'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Card(
                      child: ListTile(
                        leading: const Text('Notifcation'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Card(
                      child: ListTile(
                        leading: const Text('About Us'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: Colors.black, width: 3),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  //get pic from mobile
  Future<void> getImage() async {
    print('image');
    final _imagepicker = ImagePicker();
    try {
      final image = await _imagepicker.pickImage(source: ImageSource.gallery);
      await updateProfile(image!);
    } catch (e) {
      print(e);
    }
  }

//upload images to firebase
  Future<void> updateProfile(XFile image) async {
    final refernce =
        FirebaseStorage.instance.ref().child('profileImage').child(image.name);
    final file = File(image.path);
    await refernce.putFile(file);
    final imageLink = await refernce.getDownloadURL();

    await userRef
        .doc(auth.currentUser!.uid)
        .update({'profileImage': imageLink});
    print(imageLink);
  }
}
