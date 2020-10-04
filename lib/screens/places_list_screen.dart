import 'package:flutter/material.dart';
import 'package:great_places/provider/great_places.dart';
import '../screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Places"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      child: Center(
                        child: Text(
                          "No Place To Show!",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: -1.2,
                              color: Colors.blue),
                        ),
                      ),
                      builder: (ctx, places, child) {
                        return places.items.length <= 0
                            ? child
                            : ListView.builder(
                                itemBuilder: (context, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(places.items[i].image),
                                  ),
                                  title: Text("${places.items[i].title}"),
                                  onTap: () {/*go to the details page.*/},
                                ),
                                itemCount: places.items.length,
                              );
                      },
                    ),
        ));
  }
}
