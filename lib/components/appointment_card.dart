import 'package:app/consts/profile.dart';
import 'package:app/utils/numbers.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
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
  final Function()? onConfirm;
  final Function()? onCancel;

  const AppointmentCard({
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
    required this.onConfirm,
    required this.onCancel,
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
                height: 24,
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

                  Expanded( // Use Expanded para permitir que o texto pule para a próxima linha
                    child: Text(
                      address,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    typePayment == 'Pix' ? Icons.pix_sharp : typePayment == 'Dinheiro' ? Icons.monetization_on : Icons.credit_card,
                    color: Colors.deepOrangeAccent,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'R\$ ${formatMoney(price)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Visibility(
                visible: status == 'Pendente',
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onConfirm,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            width: 2.0,
                            color: Colors.green,
                          ),
                        ),
                        child: const Text(
                          'Finalizar',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onCancel,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            width: 2.0,
                            color: Colors.red,
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
