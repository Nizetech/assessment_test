import 'dart:developer';

import 'package:assessment_test/auth/login_account.dart';
import 'package:assessment_test/constant/api_constant.dart';
import 'package:assessment_test/theme/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController controller = CarouselController();
  int currentIndex = 0;
  Box box = Hive.box(kAppName);

  List tabs = [
    'All',
    'Fashion',
    'Sport',
    'Phones',
    'Electronics',
  ];
  List isBlueFrame = [
    true,
    false,
    true,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: Image.asset('assets/profile.png'),
                          ),
                          SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  color: Color(0xFF434343),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Tolu Oluyole',
                                style: TextStyle(
                                  color: Color(0xFF434343),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              box.delete('token');
                              Get.to(LoginAccount());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 27),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Search ',
                                fillColor: Color(0xFFF9F9F9),
                                filled: true,
                                hintStyle: const TextStyle(
                                  color: Color(0xFF434343),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                prefixIcon: Transform.scale(
                                  scale: .5,
                                  child: Image.asset('assets/search_icon.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xFF2676FC),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset('assets/slider.png')),
                        ],
                      ),
                      SizedBox(height: 35),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Items',
                            style: TextStyle(
                              color: Color(0xFF020F3A),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'View All',
                            style: TextStyle(
                              color: Color(0xFF434343),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 23),
                CarouselSlider(
                  options: CarouselOptions(
                    pageSnapping: false,
                    height: 175,
                    aspectRatio: .5,
                    viewportFraction: 0.85,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: isBlueFrame.map((i) {
                    int index = isBlueFrame.indexOf(i);
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 167,
                          width: 290,
                          margin: EdgeInsets.only(right: index == 2 ? 20 : 0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(i == true
                                  ? 'assets/frame.png'
                                  : 'assets/yellow_frame.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  children: [
                                    SizedBox(height: 30),
                                    const Text(
                                      'Get your special\n sale upto 50%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 21),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text('Shop Now',
                                            style: TextStyle(
                                              color: i == true
                                                  ? mainColor
                                                  : Colors.amber,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            )))
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/ads.png',
                                height: 138,
                                width: 138,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 30),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      isBlueFrame.length,
                      (index) {
                        return Container(
                          height: 10,
                          width: 10,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: currentIndex != index ? grey : Colors.amber,
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        labelStyle: TextStyle(
                          color: Color(0xFF434343),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                        unselectedLabelStyle: TextStyle(
                          color: Color(0xFF949494),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        tabs: tabs
                            .map((e) => Tab(
                                  text: e,
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 44),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .76,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffF9F4F1),
                                ),
                                child: Image.asset('assets/boxer.png'),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Fashionable Shorts',
                                style: TextStyle(
                                  color: Color(0xFF434343),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5),
                              const Text(
                                'NGN 10,500',
                                style: TextStyle(
                                  color: Color(0xFF434343),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 44),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
