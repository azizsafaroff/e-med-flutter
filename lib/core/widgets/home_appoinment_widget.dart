import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'emed_text.dart';

class HomeAppoinmentWidget extends StatelessWidget {
  final dynamic doctor;
  final dynamic appoinmentTime;
  const HomeAppoinmentWidget({
    Key? key,
    required this.doctor,
    required this.appoinmentTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
          leading: CircleAvatar(
            radius: 32.0,
            backgroundImage: NetworkImage(
              doctor['image'],
            ),
          ),
          title: EmedText(
            text: doctor['speciality'],
            color: Colors.black,
            fontWeight: FontWeight.bold,
            size: 18.0,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.clock,
                    size: 16.0,
                    color: Color(0xFF8418D9),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: EmedText(
                      text: appoinmentTime,
                      size: 16.0,
                      color: const Color(0xFF8418D9),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/doctor.svg',
                    width: 16.0,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: EmedText(
                      text: doctor['name'],
                      size: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/hospital.svg',
                    width: 16.0,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: EmedText(
                      text: doctor['place_work'],
                      size: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(height: 0),
        ),
      ],
    );
  }
}
