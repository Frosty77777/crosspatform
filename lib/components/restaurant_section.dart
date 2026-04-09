import 'package:flutter/material.dart';

import '../components/restaurant_landscape_card.dart';
import '../models/restaurant.dart';

class RestaurantSection extends StatelessWidget {
  final List<Restaurant> restaurants;
  const RestaurantSection({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              bottom: 8.0,
            ),
            child: Text(
              'Cars near me',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 230,
            // Horizontal list keeps car cards easy to scan quickly.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: RestaurantLandscapeCard(
                    restaurant: restaurants[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
