// este archivo contiene las variables de entorno estaticas para mayor comodidad al momento del llamado 

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay Key';




}