

import 'package:flutter/material.dart';

class AppTheme {


/*
  Tema principal de la app, cualquier cambio en el tema es aacá
  uso de material en toda la app y un color.
**/
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,colorScheme: const ColorScheme.dark()

  );

}