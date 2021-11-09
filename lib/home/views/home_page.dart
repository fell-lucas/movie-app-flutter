import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Center(
                  child: Text(
                    'Search the movies you always wanted to watch and add them to your watchlist',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.house),
          ),
          BottomNavigationBarItem(
            label: 'My Movies',
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}
