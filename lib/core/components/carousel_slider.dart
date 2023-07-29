import 'package:app/core/data/models/item_model.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GarboSlider extends StatefulWidget {
  final List<Item> items;
  const GarboSlider({super.key, required this.items});

  @override
  State<GarboSlider> createState() => _GarboSliderState();
}

class _GarboSliderState extends State<GarboSlider> {
  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index, realIndex) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: size.width * 0.3,
                          child:
                              ImageUtils().getImage(widget.items[index].image)),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.items[index].name,
                              style: const TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.items[index].description,
                              style: const TextStyle(
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 1,
            height: 230,
            onPageChanged: (index, reason) {
              setState(() {
                sliderIndex = index;
              });
            },
            autoPlay: true,
          ),
        ),
        Positioned(
          bottom: 15,
          width: size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...widget.items.map(
                (e) => AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: widget.items.indexOf(e) == sliderIndex ? 12 : 8,
                  width: widget.items.indexOf(e) == sliderIndex ? 12 : 8,
                  decoration: BoxDecoration(
                    color: widget.items.indexOf(e) == sliderIndex
                        ? Colors.black54
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
