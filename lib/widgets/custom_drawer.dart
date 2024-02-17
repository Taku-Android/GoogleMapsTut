import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(
      {super.key, required this.onNormalTap, required this.onRetroTap, required this.onNightTap});

  final Function() onNormalTap;

  final Function() onRetroTap;
  final Function() onNightTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onRetroTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ListTile(
                  leading: Text('1.'),
                  title: Text('Map Retro Style'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: onNormalTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ListTile(
                  leading: Text('2.'),
                  title: Text('Map Normal Style'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: onNightTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ListTile(
                  leading: Text('3.'),
                  title: Text('Map Night Style'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
