import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class ReviewCard extends StatefulWidget {
  final String name;
  final String? url;
  const ReviewCard({super.key, required this.name, this.url});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        height: scaleH(197, context),
        width: scaleW(260, context),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: scaleH(177, context),
                width: scaleW(260, context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Thank you ',
                          style: AppTheme.textTheme.bodyLarge,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'a verified review',
                            style: AppTheme.textTheme.bodyMedium!
                                .copyWith(color: const Color(0xFFBBC3CE)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 10, 0),
                            child: Image(
                              image: AssetImage('assets/icons/success.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '26.02.2019',
                            style: AppTheme.textTheme.bodySmall!
                                .copyWith(color: const Color(0xFFBBC3CE)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                  height: scaleH(72, context),
                  width: scaleW(72, context),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage('assets/imgs/profileImgs/photo.png')),
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: scaleW(10, context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTheme.textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
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
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
