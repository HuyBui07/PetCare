import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import '../services/auth_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteGenerator.pro5);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF4552CB),
            )),
        title: Text(
          'Settings',
          style: AppTheme.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4552CB),
              letterSpacing: 0,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(),
            color: AppColors.lightgray,
            surfaceTintColor: Colors.transparent,
            shadowColor: AppColors.lightgray.withOpacity(0.2),
            child: ListTile(
              onTap: () async {
                await Provider.of<LogProvider>(context, listen: false)
                    .loggingOut();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SignIn(),
                    ),
                  );
                }
              },
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.violet.withOpacity(0.15)),
                child: Padding(
                    padding: EdgeInsets.all(scaleH(10, context)),
                    child: const Icon(Icons.logout)),
              ),
              title: Text(
                "Log out",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: scaleH(2, context),
                  horizontal: scaleW(20, context)),
            ),
          )
        ],
      ),
    );
  }
}
