import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/OrderPage/OrderPage.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 290,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/imgdetail.png"),
                      // Update the image path
                      fit: BoxFit
                          .contain, // Use BoxFit.cover to fill the container
                    ),
                    color: Color.fromARGB(255, 173, 8, 8),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                            padding: EdgeInsets.all(17),
                            child:
                                Image.asset("assets/images/arrow-left.png"))),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 17,
                    left: 17,
                    right: 17,
                    bottom: 4,
                  ),
                  child: Text(
                    "Boneless Sour and Spicy Chicken",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 17,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/vectors/star_solid.svg"),
                      SvgPicture.asset("assets/vectors/star_solid.svg"),
                      SvgPicture.asset("assets/vectors/star_solid.svg"),
                      SvgPicture.asset("assets/vectors/star_solid.svg"),
                      SvgPicture.asset("assets/vectors/star_solid.svg"),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "443 reviews",
                          style: TextStyle(
                              color: Color.fromRGBO(147, 147, 147, 1),
                              fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  child: Text(
                    "\$ 332.00",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color.fromRGBO(219, 22, 110, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 5, 17, 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "Opening:",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "6:00am - 22:00pm",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(147, 147, 147, 1)),
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(219, 22, 110, 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderScreen()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'BOOKING NOW',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 17.0),
                  child: Divider(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    thickness: 14,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(17, 5, 17, 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(147, 147, 147, 1)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Food is scrumptious, delicious, delectable, luscious, great tasting, much more than tasty, really appetizing, lip-smacking; the kind of food to have you licking your lips in anticipation. This is the word everyone wants to hear when bringing food to the table. Yummy food is never unpalatable, plain tasting, distasteful or disgusting. Veiw more",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 17.0),
                  child: Divider(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    thickness: 14,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(17, 5, 17, 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service criteria:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 180, 30, 0)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          " ❣ Food quality: The food should be fresh, well-prepared, and flavorful.\n ❣ Service: The service should be friendly, attentive, and efficient.\n ❣ Ambiance: The atmosphere should be inviting and comfortable.\n ❣ Value: The price should be reasonable for the quality of food and service.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 206, 48, 16)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 17.0),
                  child: Divider(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    thickness: 14,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Text("Reviews",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ),
                Container(
                  child: Column(
                    children: [
                      ListReview(),
                      ListReview(),
                      ListReview(),
                      ListReview(),
                      ListReview(),
                      ListReview(),
                      ListReview(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ListReview() {
    return Column(
      children: [
        const Divider(
          color: Color.fromRGBO(220, 220, 220, 0.7),
          thickness: 0.8,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(17, 10, 17, 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/avtuser.png",
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Dương Mạnh",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/vectors/star_solid.svg",
                              ),
                              SvgPicture.asset(
                                "assets/vectors/star_solid.svg",
                              ),
                              SvgPicture.asset(
                                "assets/vectors/star_solid.svg",
                              ),
                              SvgPicture.asset(
                                "assets/vectors/star_solid.svg",
                              ),
                              SvgPicture.asset(
                                "assets/vectors/star_solid.svg",
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "21 giờ trước",
                            style: TextStyle(
                              color: Color.fromRGBO(95, 95, 95, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Thịt gà mềm, nước sốt ngon tuyệt! Món ăn đa dạng và phong phú. Sẽ ủng hộ quán nhiều hơn nữa !",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
