import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/search_results.dart';

class DateBottomSheet extends StatefulWidget {
  const DateBottomSheet(
      {super.key,
      required this.subContext,
      required this.parentContext,
      required this.speciality});

  final BuildContext subContext;
  final BuildContext parentContext;
  final String speciality;

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
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
              'Select a date',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            initialDateTime: date,
            mode: CupertinoDatePickerMode.date,
            showDayOfWeek: true,
            dateOrder: DatePickerDateOrder.dmy,
            onDateTimeChanged: (DateTime newDate) {
              setState(() => date = newDate);
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 45,
              width: 160,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(widget.subContext);
                  Navigator.push(
                    widget.parentContext,
                    MaterialPageRoute(
                      builder: (ctx) => SearchResults(
                        date: date,
                        speciality: widget.speciality,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Show results',
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 45,
              width: 160,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 230, 230, 230),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(widget.subContext);
                  Navigator.push(
                    widget.parentContext,
                    MaterialPageRoute(
                      builder: (ctx) => SearchResults(
                        date: DateTime.now(),
                        speciality: widget.speciality,
                      ),
                    ),
                  );
                },
                child: const Text('Skip'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
