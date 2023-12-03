import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Data/ModelDta.dart';
import 'DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    CallAPI();
  }

  String url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  final dio = Dio();
  Poke_Mon? poke;

  CallAPI() async {
    var res = await dio.get(url);
    var decodedJson = jsonDecode(res.data);
    poke = Poke_Mon.fromJson(decodedJson);
    print(poke!.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: poke == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: poke!.pokemon!
                  .map((poke) => GestureDetector(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                      herro: poke.name,
                                        )));
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  transitionOnUserGestures: true,
                                  tag: {poke.name},
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                (poke.img) as String))),
                                  ),
                                ),
                                Text(
                                  (poke.name) as String,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
