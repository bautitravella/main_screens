import 'package:flutter/material.dart';

class Example9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Test"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
          } )
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {

  final cities = [
    "Apple",
    "Watermelon",
    "Orange",
    "Pear",
    "Cherry",
    "Strawberry",
    "Nectarine",
    "Grape",
    "Mango",
    "Blueberry",
    "Pomegranat",
    "Carambola",
    "Plum",
    "Banana",
    "Raspberry",
    "Mandarin",
    "Jackfruit",
    "Papaya",
    "Kiwi",
    "Pineapple",
    "Lime",
    "Lemon",
    "Apricot",
    "Grapefruit",
    "Melon",
    "Coconut",
    "Avocado",
    "Peach",
  ];
  final recentCities = [
    "Grapefruit",
    "Melon",
    "Coconut",
    "Avocado",
    "Peach",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
   return IconButton(
     icon: AnimatedIcon(
       icon: AnimatedIcons.menu_arrow,
       progress: transitionAnimation,
     ),
     onPressed: () {
       close(context, null);
     },
   );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result bases on the selection
    return Card(
      color: Colors.red,
      shape: StadiumBorder(),
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ?recentCities
        :cities.where((p) =>p.startsWith(query)).toList();

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
         onTap: () {
           showResults(context);
         },
          leading: Icon(Icons.location_city),
          title: Text(suggestionList[index]),
    ),
      itemCount: suggestionList.length,
    );
  }

}
