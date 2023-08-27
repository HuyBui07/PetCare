import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/dentist_list.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/customTabBart.dart';

class SearchResults extends StatefulWidget {
  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                                onPressed: () {},
                                icon: Icon(
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
                                  height: 32,
                                  width: 200,
                                  tab1: 'Spacialists',
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
                                      .headline6
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
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.lightgray,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xff070821),
                                size: 27,
                              ),
                              hintText: 'search',
                              hintStyle:
                                  Theme.of(context).textTheme.headline5?.apply(
                                        color: AppColors.gray,
                                      ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
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
                              Container(
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
                                    '9 Sep',
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
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
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
                                    'Dentist',
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
                              Container(
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
                Expanded(
                  child: DentisList(
                    dentists: [
                      'Vasilenko Okasana',
                      'Lauren Sell',
                      'Aleseenko Valsy',
                      'Lalisa Manoban',
                      'Kim Jenie',
                      'Kim Jisoo',
                      'Park Chaeyoung'
                    ],
                  ),
                ),
                Center(
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
