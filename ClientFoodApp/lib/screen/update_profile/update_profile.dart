import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:foodapp/api/user.api.dart';
import 'package:foodapp/screen/person_page/person_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/assets_dir/assets_direct.dart';
import '../../models/entities/user.entity.dart';
import '../../models/enums/loadStatus.dart';

import 'package:http/http.dart' as http;

import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/select_image/select_image_widget.dart';

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
  Widget myImageWidget = Image.network(
    assetsDirect.errAvt,
    width: 100.0,
    height: 100.0,
    fit: BoxFit.cover,
  );

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
        myImageWidget = Image.network(
          userEntity?.avatarThumbnail ?? assetsDirect.errAvt,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        );
      });
    } else {
      loadStatus = LoadStatus.failure;
      throw Exception('Failed to load data');
    }
  }

  File? _image;
  final picker = ImagePicker();

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(" Ảnh :>>>>>>>>>> ${_image?.path}");
        myImageWidget = Image.file(
          _image!,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        );
        Navigator.pop(context);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(" Ảnh :>>>>>>>>>> $_image");
        myImageWidget = Image.file(
          _image!,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        );
        Navigator.pop(context);
      }
    });
  }

  Future<void> pushData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String apiUrlUser = ApiUser.postUpdateUserEndpoint;
      String apiUrlUserAvatar =
          ApiUser.postAvatarUserEndpoint(int.parse(idUser));

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
        if (_image != null) {
          var request =
              http.MultipartRequest('POST', Uri.parse(apiUrlUserAvatar));

          // Đọc dữ liệu nhị phân từ file
          List<int> bytes = await _image!.readAsBytes();

          // Sử dụng dữ liệu nhị phân để tạo MultipartFile
          request.files.add(http.MultipartFile.fromBytes(
            'avatar_thumbnail',
            bytes,
            filename: 'avatar.jpg',
            contentType: MediaType('image', 'jpeg'),
          ));

          var avatarResponse = await request.send();

          if (avatarResponse.statusCode == 200) {
            setState(() {
              loadUpdate = LoadStatus.success;
            });
          } else {
            throw Exception('Failed to upload avatar');
          }
        }
        setState(() {
          loadUpdate = LoadStatus.success;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PersonScreen()),
        );
      } else {
        throw Exception('Failed to upload data');
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
      appBar: const AppBarWidget(title: "UPDATE INFOMATION"),
      body: loadStatus == LoadStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : loadStatus == LoadStatus.failure
              ? const Center(child: Text("No data available"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: ListView(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: assetsDirect.homeColor,
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      60.0), // Nửa của radius của CircleAvatar
                                ),
                                child: ClipOval(child: myImageWidget),
                              ),
                              Container(
                                width: 120,
                                height: 40,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: assetsDirect.homeColor,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      60.0), // Nửa của radius của CircleAvatar
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isDismissible: false,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return SelectUploadImage(
                                          getImageFromCamera:
                                              getImageFromCamera,
                                          getImageFromGallery:
                                              getImageFromGallery,
                                          image: _image,
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 48,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Select Image",
                                        style: TextStyle(
                                          color: assetsDirect.homeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
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
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: assetsDirect.homeColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () {
                            pushData();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: assetsDirect.homeColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: loadUpdate == LoadStatus.loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
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
