import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import '../users/user_data.dart';
//import 'package:petcare_search/constants/styles.dart';

List<ListItem> items = [
  ListItem(
      label: 'My pets',
      iconSVG: SvgPicture.asset(
        'assets/icons/iconsvg/pets.svg',
      ),
      route: RouteGenerator.petpro5),
  ListItem(
      label: 'My favourites',
      icon: const Icon(
        Icons.favorite_border_outlined,
        color: AppColors.violet,
      ),
      route: 'RouteGenerator.editpro5'),
  ListItem(
      label: 'Add pet service',
      icon:
          const Icon(Icons.medical_services_outlined, color: AppColors.violet),
      route: 'RouteGenerator.editpro5'),
  ListItem(
      label: 'Invite friends',
      iconSVG: SvgPicture.asset(
        'assets/icons/iconsvg/megaphone.svg',
      ),
      route: 'RouteGenerator.editpro5'),
  ListItem(
      label: 'Help',
      icon: const Icon(Icons.help_outline, color: AppColors.violet),
      route: 'RouteGenerator.editpro5'),
  ListItem(
      label: 'Settings',
      icon: const Icon(Icons.settings_outlined, color: AppColors.violet),
      route: RouteGenerator.settingsscreen),
];

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteGenerator.editpro5);
            },
            child: Row(children: [
              Icon(
                Icons.edit_outlined,
                color: AppColors.violet,
              ),
              Text('Edit',
                  style: Theme.of(context).textTheme.headline6?.apply(
                        color: AppColors.violet,
                      )),
              SizedBox(
                width: scaleW(20, context),
              )
            ]),
          ),
        ],
      ),
      body: Container(
        color: AppColors.lightgray,
        child: Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(bottom: scaleH(10, context)),
              height: scaleH(226, context),
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
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      foregroundImage: GlobalData.avatar != null
                          ? NetworkImage(GlobalData.avatar.toString())
                          : const NetworkImage(
                              'https://www.gravatar.com/avatar/?d=blank'),
                      radius: scaleW(56, context),
                    ),
                    Column(
                      children: [
                        Text(
                          GlobalData.displayName.toString(),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          'Kive',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: AppColors.gray),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(),
                      color: AppColors.lightgray,
                      surfaceTintColor: Colors.transparent,
                      shadowColor: AppColors.lightgray.withOpacity(0.2),
                      child: ListTile(
                        onTap: () => {
                          Navigator.pushNamed(context, items[index].route),
                        },
                        leading: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.violet.withOpacity(0.15)),
                          child: Padding(
                            padding: EdgeInsets.all(scaleH(10, context)),
                            child: items[index].icon != null
                                ? items[index].icon
                                : items[index].iconSVG,
                          ),
                        ),
                        title: Text(
                          items[index].label,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: scaleH(2, context),
                            horizontal: scaleW(20, context)),
                        trailing: const Icon(
                          Icons.navigate_next,
                          color: AppColors.gray,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem {
  final String label;
  final SvgPicture? iconSVG;
  final Icon? icon;
  String route;

  ListItem({required this.label, this.iconSVG, this.icon, required this.route});
}
