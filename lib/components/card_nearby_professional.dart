import 'package:app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardNearbyProfessional extends StatelessWidget {
  final String name;
  final String position;
  final int totalBookings;
  final double priceHour;
  final double distance;

  const CardNearbyProfessional({
    super.key,
    required this.name,
    required this.position,
    required this.totalBookings,
    required this.priceHour,
    required this.distance,
  });

  String formatMoney(double value) {
    final formatINTL = NumberFormat("#,##0.00", "pt_BR");

    return formatINTL.format(value);
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  position,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    color: Color.fromRGBO(101, 101, 101, 1),
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  '$totalBookings agendamentos',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                    color: Color.fromRGBO(101, 101, 101, 1),
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'R\$ ${formatMoney(priceHour)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    const Text(
                      '/hora',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 8.0,
                        color: Color.fromRGBO(101, 101, 101, 1),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 36,
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
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
