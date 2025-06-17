import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    final List<String> favoriteTask = [];
    return favoriteTask.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.heartCircleXmark,
                size: 80,
                color: Colors.grey[400],
              ),
              SizedBox(height: 20),
              Text(
                "No favourites yet!",
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              SizedBox(height: 10),
              Text(
                "Tap the ♡ icon to add a favourite task.",
                style: TextStyle(fontSize: 16, color: Colors.white54),
              ),
            ],
          ),
        )
        : ListView.builder(
          itemCount: favoriteTask.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                favoriteTask[index],
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
  }
}
