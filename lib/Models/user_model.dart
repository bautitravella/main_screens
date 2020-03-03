
import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;
  final int rating;
  final String curso;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.rating,
    this.curso
  });
}

  List<User> users = [
    User(
      id: 0,
      name: 'Current User',
      imageUrl: 'assets/images/avatar.png',
      rating: 2,
      curso: "7° grado",
    ),
    User(
      id: 1,
      name: 'Greg Awk',
      imageUrl: 'assets/images/avatar.png',
      rating: 3,
      curso: "4° grado",
    ),
    User(
      id: 2,
      name: 'James Charles',
      imageUrl: 'assets/images/1005-viernes-fluvial-mari-343-3.png',
      rating: 3,
      curso: "2° grado",
    ),
    User(
      id: 3,
      name: 'John Ceena',
      imageUrl: 'assets/images/john.jpg',
      rating: 4,
      curso: "Senior 3",
    ),
    User(
      id: 4,
      name: 'Olivia Mayweather',
      imageUrl: 'assets/images/olivia.jpg',
      rating: 5,
      curso: "Middle 1",
    ),
    User(
      id: 5,
      name: 'Sam Oswood',
      imageUrl: 'assets/images/sam.jpg',
      rating: 2,
      curso: "Senior 3",
    ),
    User(
      id: 6,
      name: 'Sophia Torres',
      imageUrl: 'assets/images/sophia.jpg',
      rating: 4,
      curso: "4° grado",
    ),
    User(
      id: 7,
      name: 'Steven Minecraft',
      imageUrl: 'assets/images/steven.jpg',
      rating: 1,
      curso: "4° grado",
    )
  ];
