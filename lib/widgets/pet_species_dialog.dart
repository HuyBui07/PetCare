import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/pets/size.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class PetDialog extends StatelessWidget {
  String type;
  final Function onTap;
  PetDialog({super.key, required this.onTap, required this.type});
  final List<String> species = [
    'Dogs',
    'Cats',
    // 'Fish',
    // 'Birds',
    // 'Snake',
    // 'Hamsters',
    // 'Guinea pigs',
    // 'Turtles',
    // 'Frogs',
    // 'Rabbits',
    // 'Hedgehogs',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: scaleH(150, context),
      width: scaleW(300, context),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ListView.builder(
          itemCount: type == 'size' ? sizes.length : species.length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              title: type == 'size'
                  ? Text(sizes[index]
                      .keys
                      .toString()
                      .replaceAll(new RegExp(r'[^\w\s]+'), ''))
                  : Text(species[index]),
              onTap: () {
                type == 'size' ? onTap(sizes[index]) : onTap(species[index]);
                Navigator.of(context).pop();
              },
            );
          }),
    );
  }
}
