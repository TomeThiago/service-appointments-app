import 'package:app/consts/profile.dart';
import 'package:flutter/material.dart';

class NextBookingCard extends StatelessWidget {
  final String id;
  final String name;
  final String photoUrl;
  final String service;
  final String date;
  final String hour;
  final String address;
  final String status;
  final String typePayment;
  final double price;

  const NextBookingCard({
    super.key,
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.service,
    required this.date,
    required this.hour,
    required this.address,
    required this.typePayment,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String getAvatarUrl() {
      if(photoUrl.isEmpty) {
        return ProfileConst.avatarUrl;
      }

      return photoUrl;
    }

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      getAvatarUrl(),
                    ),
                    radius: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        service,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.event,
                        color: Colors.deepOrangeAccent,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: Colors.deepOrangeAccent,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        hour,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: Colors.deepOrangeAccent,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
