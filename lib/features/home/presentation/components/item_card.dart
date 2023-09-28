import 'package:app/core/data/models/item/item_model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final VoidCallback onPressed;
  final Item item;
  const ItemCard({
    required this.item,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: 140,
      child: Column(
        children: [
          Expanded(
            child: Card(
              clipBehavior: Clip.antiAlias,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Container(
                    constraints: const BoxConstraints.expand(),
                    child: Image.asset(item.image, fit: BoxFit.cover),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${item.price.toString()}€',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          onPressed: onPressed,
                          icon: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            item.name,
          ),
        ],
      ),
    );
  }
}
