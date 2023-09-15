import 'package:flutter/material.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/widgets/date_bottom_sheet.dart';

const allSpecialities = [
  'Veterinarian',
  'Therapist',
  'Anesthetist',
  'Gastroenterologist',
  'Infectious disease',
  'Cardiologist',
  'Neurologist',
  'Oncologist',
  'Ornithologist',
  'Orthopedist',
  'Ophthalmologist',
  'Radiologist',
  'Dentist',
  'Therapist',
  'Traumatologist',
  'Surgeon',
];

const popularSpecialities = [
  'Cat Specialist',
  'Dog Specialist',
  'Ornithologist',
  'Dentist',
  'Surgeon'
];

class SearchSpeciality extends StatefulWidget {
  const SearchSpeciality({super.key, required this.subContext});

  final BuildContext subContext;

  @override
  State<SearchSpeciality> createState() => _SearchSpecialityState();
}

class _SearchSpecialityState extends State<SearchSpeciality> {
  String picked_Speciality = '';

  void _pickDate() {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (ctx) => DateBottomSheet(
        subContext: context,
        parentContext: widget.subContext,
        speciality: picked_Speciality,
      ),
    );
    // Navigator.pop(context);
    // Navigator.pushNamed(widget.subContext, RouteGenerator.searchResults);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              alignment: Alignment.center,
              color: Colors.deepPurple,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                //size: 28,
              ),
            ),
            SizedBox(
              width: (width / 5),
            ),
            Text(
              'Select a speciality',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POPULAR SPECIALITIES',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.orange),
                    ),
                    for (final speciality in popularSpecialities)
                      InkWell(
                        onTap: () {
                          picked_Speciality = speciality;
                          _pickDate();
                        },
                        child: Text(speciality),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'ALL SPECIALITIES',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.orange),
                    ),
                    for (final speciality in allSpecialities)
                      InkWell(
                        onTap: () {
                          picked_Speciality = speciality;
                          _pickDate();
                        },
                        child: Text(speciality),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
