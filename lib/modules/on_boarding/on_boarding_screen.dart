// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_first_app/modules/login_screen/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boardings = [
    BoardingModel(
        image: 'assets/images/Order ahead-rafiki.png',
        title: 'Order Online',
        body: 'You Can Order Everything Online'),
    BoardingModel(
        image: 'assets/images/Ecommerce web page-bro.png',
        title: 'Discover Products',
        body: 'You can find anything in your imagination'),
    BoardingModel(
        image: 'assets/images/In no time-rafiki.png',
        title: 'Delivery Service',
        body: 'You will get your products in no time'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  navigateAndEnd(context, ShopLoginScreen());
                },
                child: Text('SKIP'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: boardController,
                    onPageChanged: (int index) {
                      if (index == boardings.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boardings[index]),
                    itemCount: boardings.length),
              ),
              SizedBox(height: 40.0),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boardings.length,
                    effect: WormEffect(
                        activeDotColor: defaultColor,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5.0),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        navigateAndEnd(context, ShopLoginScreen());
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        SizedBox(height: 30.0),
        Text(
          model.title,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.0),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 30.0),
      ]);
}
