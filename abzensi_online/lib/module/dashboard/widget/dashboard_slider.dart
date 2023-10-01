// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class DashboardSlider extends StatefulWidget {
  const DashboardSlider({Key? key}) : super(key: key);

  @override
  State<DashboardSlider> createState() => _DashboardSliderState();
}

class _DashboardSliderState extends State<DashboardSlider> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      List images = [
        "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        "https://images.unsplash.com/photo-1606857521015-7f9fcf423740?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        "https://images.unsplash.com/photo-1541746972996-4e0b0f43e02a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        "https://images.unsplash.com/photo-1564069114553-7215e1ff1890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
      ];

      return Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: 160.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 1.0,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                currentIndex = index;
                setState(() {});
              },
            ),
            items: images.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                        image: NetworkImage(
                          imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              bool isSelected = currentIndex == entry.key;
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: isSelected ? 40 : 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.only(
                    right: 6.0,
                    top: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : const Color(0xff3c3e40),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
