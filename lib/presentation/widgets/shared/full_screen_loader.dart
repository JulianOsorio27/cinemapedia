import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
    'Cargando películas',
    'Comprando palomitas',
    'Cargando populares',
    'Llamando a mi novia',
    'Ya mero...Merito',
    'Se esta demorando mucho D:',
  ];

    return Stream.periodic(const Duration(milliseconds: 1400), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espero por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) 
           {
            if (!snapshot.hasData) return const Text('Çargando...');
            
            return Text(snapshot.data!);
           }
          ),
        ],
      ),
    );
  }
}
