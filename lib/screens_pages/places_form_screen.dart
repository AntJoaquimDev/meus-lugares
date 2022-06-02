// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_place/components/image_input.dart';
import 'package:great_place/components/location_input.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

class PlaceFormeScreen extends StatefulWidget {
  @override
  State<PlaceFormeScreen> createState() => _PlaceFormeScreenState();
}

class _PlaceFormeScreenState extends State<PlaceFormeScreen> {
  final _titleController = TextEditingController();
  DateTime _data;
  File _pickedImage;
  LatLng _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _data,
      _pickedImage,
      _pickedPosition,
    );
    print('adicionou');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Titulo',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPosition),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _isValidForm() ? _submitForm : null,
            //onPressed: _submitForm,
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.primary,
              elevation: 10,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
