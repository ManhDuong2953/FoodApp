import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/SearchFood/SearchFood.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _name;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? IDUser = prefs.getString('IDUser') ??
        ''; // Nếu không có giá trị, sẽ trả về chuỗi rỗng
    final response =
        await http.get(Uri.parse('http://10.0.2.2:2953/users/info/$IDUser'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      final Map<String, dynamic> data = jsonDecode(response.body)["data"];
      setState(() {
        _name = data["name"];
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgsearch.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.4), // Điều chỉnh độ tối tùy ý ở đây
              BlendMode.darken, // Chọn chế độ tối (ở đây là tối bằng màu đen)
            ),
          ),
        ),
        child: Center(
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    top: 42,
                    left: 25,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          'https://static.vecteezy.com/system/resources/previews/000/425/647/original/avatar-icon-vector-illustration.jpg',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          "Hi, $_name",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(
                  top: 94,
                  left: 25,
                  right: 25,
                ),
                child: SizedBox(
                  width: 314,
                  height: 163,
                  child: Text(
                    "What can we serve you today?",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Đặt bán kính bo góc cho Container
                    border: Border.all(
                        color: Colors.white,
                        width: 2), // Đặt màu và độ dày viền
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () {
                            // Chuyển hướng sang trang khác khi TextField được nhấp vào
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchFoodScreen()),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.grey),
                                const SizedBox(width: 8.0),
                                const Expanded(
                                  child: Text(
                                    "Search for address, food...",
                                    style: TextStyle(
                                      color: Color.fromRGBO(138, 138, 138, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                    "assets/vectors/locationSVGIcon.svg"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
