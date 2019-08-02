import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Guardar', icon: Icons.directions_car),
  const Choice(title: 'Salir', icon: Icons.directions_bike),
  const Choice(title: 'Guardar', icon: Icons.directions_car),
  const Choice(title: 'Salir', icon: Icons.directions_bike),
];