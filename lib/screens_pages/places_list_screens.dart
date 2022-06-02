// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:great_place/exceptions/http_exception.dart';
import 'package:great_place/models/place.dart';
import 'package:great_place/utils/db_util.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  final Place place;

  const PlacesListScreen({Key key, this.place}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context).settings.arguments;
    final msg = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('Nenhum Lugar cadastrado!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlaces.itemByIndex(i).image,
                            ),
                          ),
                          title: Text(greatPlaces.itemByIndex(i).title),
                          subtitle:
                              Text(greatPlaces.itemByIndex(i).location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.PLACE_DETAIL,
                              arguments: greatPlaces.items,
                            );
                          },
                          trailing: IconButton(
                            onPressed: () {
                              showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Tem Certeza?'),
                                  content:
                                      Text('Quer realmente excluir o place ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Não'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        DbUtil.delete(
                                            greatPlaces.items.indexOf(place));
                                        greatPlaces.loadPlaces();
                                        print('deletou');
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Sim'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
