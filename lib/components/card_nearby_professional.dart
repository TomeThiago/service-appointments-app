import 'package:app/utils/numbers.dart';
import 'package:flutter/material.dart';
import 'package:app/components/button.dart';

import '../consts/profile.dart';

class CardNearbyProfessional extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final int totalBookings;
  final double priceHour;
  final double distance;
  final Function()? onPressed;

  const CardNearbyProfessional({
    super.key,
    this.avatarUrl,
    required this.name,
    required this.totalBookings,
    required this.priceHour,
    required this.distance,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    String getAvatarUrl() {
      if(avatarUrl == null || avatarUrl!.isEmpty) {
        return ProfileConst.avatarUrl;
      }

      return avatarUrl ?? ProfileConst.avatarUrl;
    }

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(getAvatarUrl(),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    '$totalBookings agendamentos',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'R\$ ${formatMoney(priceHour)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      const Text(
                        '/hora',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                          color: Color.fromRGBO(101, 101, 101, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 38,
                  child: Text(
                    '$distance Km',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                  ),
                ),
                Button(
                  title: 'Agendar',
                  height: 30,
                  fontSize: 14,
                  onPressed: onPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
