import 'package:flutter/material.dart';
import 'package:app/components/button.dart';
import 'package:app/components/button_outline.dart';
import 'package:intl/intl.dart';

class NextBooking extends StatelessWidget {
  final String name;
  final String position;

  const NextBooking({
    Key? key,
    required this.name,
    required this.position,
  }) : super(key: key);

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
                  const SizedBox(height: 4.0),
                  Text(
                    position,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'R\$ ${formatMoney(50.0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      const Text(
                        '/hora',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
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
                Text(
                  '10/03/2024',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Color.fromRGBO(101, 101, 101, 1),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                ButtonOutline(
                  title: 'Cancelar',
                  height: 30,
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
