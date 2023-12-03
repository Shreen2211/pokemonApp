import 'package:flutter/material.dart';

import '../Data/ModelDta.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;
  String ? herro;

   PokeDetail({required this.herro,super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text((pokemon.name)as String),
      ),
      body:  Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    (pokemon.name) as String,
                    style:
                    const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Height: ${pokemon.height}"),
                  Text("Weight: ${pokemon.weight}"),
                  const Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type!
                        .map((t) => FilterChip(
                        backgroundColor: Colors.amber,
                        label: Text(t),
                        onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text("Weakness",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses!
                        .map((t) => FilterChip(
                        backgroundColor: Colors.red,
                        label: Text(
                          t,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text("Next Evolution",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution == null
                        ? <Widget>[const Text("This is the final form")]
                        : pokemon.nextEvolution!
                        .map((n) => FilterChip(
                      backgroundColor: Colors.green,
                      label: Text(
                        (n.name) as String,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onSelected: (b) {},
                    ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              createRectTween:(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);},
              transitionOnUserGestures: true,
              tag: {herro},
              child: Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage((pokemon.img) as String))),
              ),
            ),
          )
        ],
      ),
    );
  }
}