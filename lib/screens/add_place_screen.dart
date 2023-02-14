import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            onPressed: _savePlace,
            style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
          )
        ],
      ),
    );
  }
}