import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/addPetDetail/violetButton.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class PastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: scaleW(20, context),
                top: scaleH(40, context),
                right: scaleW(20, context)),
            child: Container(
              padding: EdgeInsets.only(
                left: scaleW(5, context),
                top: scaleH(5, context),
                right: scaleW(8, context),
              ),
              height: scaleH(319, context),
              width: scaleW(335, context),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff2E1E7A).withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(5, 3),
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
                          width: scaleW(90, context),
                          height: scaleH(90, context),
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
                              'Alekseenko Vasily',
                              style:
                                  Theme.of(context).textTheme.headline3?.apply(
                                        color: Color(0xff070821),
                                      ),
                            ),
                            Text(
                              'Vaterinary Dentist',
                              style:
                                  Theme.of(context).textTheme.headline5?.apply(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.apply(
                                        color: AppColors.gray,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: scaleH(8, context),
                            ),
                            Row(
                              children: [
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.apply(
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
                                    icon: SvgPicture.asset(
                                        'assets/icons/iconsvg/wallet.svg'),
                                  ),
                                ),
                                SizedBox(
                                  width: scaleW(8, context),
                                ),
                                Text(
                                  '20',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.apply(
                                        color: Color(0xff070821),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: scaleH(15, context),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: scaleW(5, context),
                        top: scaleH(5, context),
                        right: scaleW(8, context),
                      ),
                      height: scaleH(112, context),
                      width: scaleW(300, context),
                      decoration: BoxDecoration(
                        color: AppColors.lightgray,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(scaleH(8, context)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: scaleH(41, context),
                                  width: scaleH(41, context),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xffF0F0F8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/icons/iconsvg/work.svg'),
                                  ),
                                ),
                                SizedBox(
                                  width: scaleW(8, context),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Veterinary clinic "Alden-Vet"',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.apply(
                                            color: Color(0xff070821),
                                          ),
                                    ),
                                    SizedBox(
                                      height: scaleW(3, context),
                                    ),
                                    Text(
                                      '141N Union Ave, Los Angeles, CA',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.apply(
                                            color: Color(0xff070821),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: scaleH(8, context)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: scaleH(41, context),
                                  width: scaleH(41, context),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xffF0F0F8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/icons/iconsvg/icon clock.svg'),
                                  ),
                                ),
                                SizedBox(
                                  width: scaleW(8, context),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: scaleH(10, context)),
                                      child: Text(
                                        'Wed 9 Sep - 10:30 am',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.apply(
                                              color: Color(0xff070821),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18 ),
                      child: Row(
                        children: [
                          Container(
                            height: scaleH(34, context),
                            width: scaleW(140, context),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xff4552CB),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(scaleW(24, context)),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Edit',
                                style: Theme.of(context).textTheme.button!.apply(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: scaleH(34, context),
                            width: scaleW(140, context),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.lightgrey2,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(scaleW(24, context)),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Cancel',
                                style: Theme.of(context).textTheme.button!.apply(
                                      color: Color(0xff070821),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
