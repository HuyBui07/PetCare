import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/screens/search_tab/vetenary_info.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DentistItem extends StatelessWidget {
  const DentistItem({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (_) => VeterinaryInfo(
                    name: name,
                  ))),
      child: Padding(
        padding: EdgeInsets.all(scaleH(8, context)),
        child: Container(
          padding: EdgeInsets.only(
            left: scaleW(8, context),
            right: scaleW(8, context),
          ),
          height: scaleH(160, context),
          width: scaleW(335, context),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff2D368A).withOpacity(0.008),
                spreadRadius: 1,
                blurRadius: 28,
                offset: const Offset(4, 6),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: scaleW(72, context),
                      height: scaleH(72, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Image.asset(
                        'assets/imgs/searchResultsImgs/Photo1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: scaleW(16, context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.headline3?.apply(
                                color: Color(0xff070821),
                              ),
                        ),
                        Text(
                          'Vaterinary Dentist',
                          style: Theme.of(context).textTheme.headline5?.apply(
                                color: Color(0xff070821),
                              ),
                        ),
                        SizedBox(
                          height: scaleH(8, context),
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              itemSize: 16,
                              initialRating: 2.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (ctx, star) {
                                return const Icon(
                                  Icons.star,
                                  color: Color(0xffFFCF6F),
                                );
                              },
                              onRatingUpdate: (rating) {},
                            ),
                            SizedBox(
                              width: scaleW(8, context),
                            ),
                            Text(
                              '125 Reviews',
                              style: Theme.of(context).textTheme.caption?.apply(
                                    color: AppColors.gray,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: scaleH(8, context),
                ),
                Row(
                  children: [
                    Text(
                      '10',
                      style: Theme.of(context).textTheme.headline5?.apply(
                            color: AppColors.gray,
                          ),
                    ),
                    SizedBox(width: scaleW(3, context)),
                    Text(
                      'years of experience',
                      style: Theme.of(context).textTheme.caption?.apply(
                            color: AppColors.gray,
                          ),
                    ),
                    SizedBox(
                      width: scaleW(10, context),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.lightgray,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                            'assets/icons/iconsvg/location.svg'),
                      ),
                    ),
                    SizedBox(
                      width: scaleW(8, context),
                    ),
                    Text(
                      '1.5km',
                      style: Theme.of(context).textTheme.caption?.apply(
                            color: Color(0xff070821),
                          ),
                    ),
                    SizedBox(
                      width: scaleW(10, context),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.lightgray,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon:
                            SvgPicture.asset('assets/icons/iconsvg/wallet.svg'),
                      ),
                    ),
                    SizedBox(
                      width: scaleW(8, context),
                    ),
                    Text(
                      '20',
                      style: Theme.of(context).textTheme.caption?.apply(
                            color: const Color(0xff070821),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
