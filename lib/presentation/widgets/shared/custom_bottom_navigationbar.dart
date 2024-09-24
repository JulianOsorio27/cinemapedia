import 'package:flutter/material.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  const CustomBottomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;


    return BottomNavigationBar(
      elevation: 0,
      selectedItemColor: colors.primary,
      items: const [

        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio', 
        ), 
    
        BottomNavigationBarItem(
          icon: Icon(Icons.lan_outlined),
          label: 'Categorías'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos'
        ),
      ],
    );
  }
}