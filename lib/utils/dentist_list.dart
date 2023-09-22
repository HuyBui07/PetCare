import 'package:flutter/material.dart';
import 'package:petcare_search/utils/dentist_item.dart';
import 'package:petcare_search/vetenaries/veterinary_args.dart';

class DentisList extends StatelessWidget {
  const DentisList({super.key, required this.dentists});

  final List<VetArgs> dentists;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dentists.length,
      itemBuilder: (ctx, index) {
        return DentistItem(
          vetArgs: dentists[index],
        );
      },
    );
  }
}
