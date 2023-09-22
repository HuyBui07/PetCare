import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/dentist_list.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/vetenaries/veterinary_args.dart';

import 'package:petcare_search/widgets/customTabBart.dart';
import '../../repository/vetRepository.dart';

final formatter = DateFormat('d MMM', 'en_US');

class SearchResults extends StatefulWidget {
  const SearchResults(
      {super.key, required this.date, required this.speciality});

  final DateTime date;
  final String speciality;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  static List<VetArgs> mainDentistList = VeterinaryRepository.vets;

  List<VetArgs> displayList = mainDentistList;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void updateList(String value) {
    setState(() {
      displayList = mainDentistList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.lightgray,
            child: Column(
              children: [
                Container(
                  height: scaleH(215, context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff2D368A).withOpacity(0.064),
                          offset: const Offset(
                            4.0,
                            6.0,
                          ),
                          blurRadius: 28.0,
                          spreadRadius: 0)
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(scaleW(34, context)),
                      bottomRight: Radius.circular(scaleW(34, context)),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: scaleH(20, context)),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.violet,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomTabBar(
                                  height: scaleH(32, context),
                                  width: scaleH(200, context),
                                  tab1: 'Specialists',
                                  tab2: 'Clinics'),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: scaleW(20, context)),
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.location_on_outlined),
                                label: Text(
                                  'Map',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                        color: AppColors.violet,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: scaleW(20, context),
                              top: scaleH(10, context),
                              right: scaleW(20, context)),
                          child: TextField(
                            onChanged: (value) => updateList(value),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.lightgray,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xff070821),
                                size: 27,
                              ),
                              hintText: 'search',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.apply(
                                    color: AppColors.gray,
                                  ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(8),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: scaleW(20, context),
                              top: scaleH(16, context),
                              right: scaleW(20, context)),
                          child: Row(
                            children: [
                              SizedBox(
                                height: scaleH(33, context),
                                width: scaleW(91, context),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.violet,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 19,
                                  ),
                                  label: Text(
                                    formatter.format(widget.date),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.apply(
                                          color: Colors.white,
                                        ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                height: scaleH(33, context),
                                width: scaleW(91, context),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.violet,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    widget.speciality,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.apply(
                                          color: Colors.white,
                                        ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: scaleH(33, context),
                                width: scaleW(91, context),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.lightgray,
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: SvgPicture.asset(
                                      'assets/icons/iconsvg/filter.svg'),
                                  label: Text('Filter',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                DentisList(
                  dentists: displayList,
                ),
                const Center(
                  child: Text(
                    'Clinics',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
