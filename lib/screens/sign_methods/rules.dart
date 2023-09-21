import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/screens/sign_methods/sign_up.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const SignUp()));
          },
        ),
        title: Text(
          'Rules',
          style: AppTheme.textTheme.displayLarge!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. You are from humankind',
              style: AppTheme.textTheme.displayMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            Text('2. You love animals',
                style: AppTheme.textTheme.displayMedium),
            const SizedBox(
              height: 30,
            ),
            Text('3. You have a phone', style: AppTheme.textTheme.displayMedium)
          ],
        ),
      ),
    );
  }
}
