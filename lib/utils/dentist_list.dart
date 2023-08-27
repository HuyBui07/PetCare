import 'package:flutter/material.dart';
import 'package:petcare_search/utils/dentist_item.dart';


class DentisList extends StatelessWidget {
  const DentisList({super.key, required this.dentists});

  final List<String> dentists;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dentists.length,
      itemBuilder: (ctx, index) {
        return DentistItem(name: dentists[index]);
      },
    );
  }
}
