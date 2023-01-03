import 'package:flutter/material.dart';
import 'package:nrental/model/user.dart';
import 'package:nrental/repository/user_repository.dart';
import 'package:nrental/response/user_response.dart';
import 'package:nrental/utils/url.dart';

class WearOSProfileScreen extends StatefulWidget {
  const WearOSProfileScreen({Key? key}) : super(key: key);

  @override
  State<WearOSProfileScreen> createState() => _WearOSProfileScreenState();
}

class _WearOSProfileScreenState extends State<WearOSProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<UserResponse?>(
              future: UserRepository().getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    User userData = snapshot.data!.data!;
                    print(userData);
                    return (_profileDetails(userData));
                  } else {
                    return const Text("No data");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget _profileDetails(userData) => Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 15,
              backgroundImage: userData.profile_img != null
                  ? NetworkImage('$baseUrl${userData.profile_img}')
                  : const NetworkImage(
                      'https://icg.webspace.durham.ac.uk/wp-content/uploads/sites/142/2021/04/4x5-Avatar.jpg'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
              child: Text(
            "${userData.username}",
            style: const TextStyle(
              fontSize: 10,
            ),
          )),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              enabled: false, //Not clickable and not editable.
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: InputBorder.none,
                labelText: userData.firstname != null
                    ? "${userData.firstname} ${userData.lastname}"
                    : "----------- ------------",
                labelStyle: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 57, 56, 56)),
                prefixIcon: const Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    Icons.person,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              enabled: false, //Not clickable and not editable.
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: InputBorder.none,
                labelText: "${userData.email}",
                labelStyle: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 57, 56, 56)),
                prefixIcon: const Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    Icons.mail,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              enabled: false, //Not clickable and not editable.
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: InputBorder.none,
                labelText: "${userData.phone}",
                labelStyle: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 57, 56, 56)),
                prefixIcon: const Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    Icons.phone,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              enabled: false, //Not clickable and not editable.
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: InputBorder.none,
                labelText: userData.address != null
                    ? "${userData.address}"
                    : "----------",
                labelStyle: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 57, 56, 56)),
                prefixIcon: const Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    Icons.house,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              enabled: false, //Not clickable and not editable.
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: InputBorder.none,
                labelText:
                    userData.gender != null ? "${userData.gender}" : "------",
                labelStyle: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 57, 56, 56)),
                prefixIcon: const Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    Icons.male,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
