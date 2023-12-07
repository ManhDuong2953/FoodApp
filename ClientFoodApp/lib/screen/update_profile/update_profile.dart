import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/api/user.api.dart';
import 'package:foodapp/screen/person_page/person_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/entities/user.entity.dart';
import '../../models/enums/loadStatus.dart';

import 'package:http/http.dart' as http;

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  User? userEntity;
  User? userEntityUpdate;
  LoadStatus loadStatus = LoadStatus.loading;
  LoadStatus loadUpdate = LoadStatus.success;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser') ?? '';
    final response =
        await http.get(Uri.parse(ApiUser.getUserEndpoint(int.parse(idUser))));
    setState(() {
      loadStatus = LoadStatus.loading;
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)["data"];
      setState(() {
        loadStatus = LoadStatus.success;
        userEntity = User.fromJson(data);
        nameController.text = userEntity?.name ?? '';
        phoneNumberController.text = userEntity?.phoneNumber ?? '';
        addressController.text = userEntity?.address ?? '';
        passwordController.text = userEntity?.password ?? '';
      });
    } else {
      loadStatus = LoadStatus.failure;
      throw Exception('Failed to load data');
    }
  }

  Future<void> pushData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String apiUrlUser = ApiUser.postUpdateUserEndpoint;
      setState(() {
        loadUpdate = LoadStatus.loading;
      });
      userEntityUpdate = User(
        id: int.parse(idUser),
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        password: passwordController.text,
      );

      final response = await http.post(
        Uri.parse(apiUrlUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode(userEntityUpdate?.toJson()),
      );

      if (response.statusCode == 200) {
        setState(() {
          loadUpdate = LoadStatus.success;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PersonScreen()));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadUpdate = LoadStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Information'),
        backgroundColor: const Color.fromRGBO(219, 22, 110, 1),
      ),
      body: loadStatus == LoadStatus.loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : loadStatus == LoadStatus.failure
              ? const Center(child: Text("No data available"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: ListView(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(219, 22, 110, 1),
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                  60.0), // Nửa của radius của CircleAvatar
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                "${userEntity?.avatarThumbnail}" ??
                                    'https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png', // Thay đổi đường dẫn hình ảnh tùy ý
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(219, 22, 110, 1)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(219, 22, 110, 1)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(219, 22, 110, 1)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(219, 22, 110, 1)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () {
                            pushData();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(219, 22, 110, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: loadUpdate == LoadStatus.loading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : loadUpdate == LoadStatus.failure
                                    ? const Center(
                                        child:
                                            Text("ERROR! PLEASE RELOAD PAGE"))
                                    : const Text(
                                        'Update now',
                                        style: TextStyle(fontSize: 18),
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
