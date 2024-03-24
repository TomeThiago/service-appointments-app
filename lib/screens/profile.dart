import 'package:app/consts/profile.dart';
import 'package:app/screens/edit_address.dart';
import 'package:app/screens/edit_user.dart';
import 'package:app/screens/select_category.dart';
import 'package:flutter/material.dart';
import 'package:app/service/auth.dart';
import 'package:app/screens/sign_in.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthServiceProvider>();
    var user = authProvider.loggedUser;

    getAvatarUrl() {
      if (authProvider.loggedUser == null ||
          authProvider.loggedUser?.avatarUrl == null) {
        return ProfileConst.avatarUrl;
      }

      if (authProvider.loggedUser!.avatarUrl!.isEmpty) {
        return ProfileConst.avatarUrl;
      }

      return authProvider.loggedUser!.avatarUrl;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(getAvatarUrl() ?? ProfileConst.avatarUrl),
                  radius: 32,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authProvider.loggedUser?.name ?? 'Visitante',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Visibility(
                      visible: user?.typeProfile == 'worker',
                      child: Text(
                        user != null
                            ? user.categoryTitle ?? 'Não informado'
                            : 'Cliente',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(user?.bio ?? ''),
                const SizedBox(
                  height: 16,
                ),
                // Visibility(
                //   visible: user?.typeProfile == 'worker',
                //   child: ServiceList(),
                // ),
                const Text(
                  'Opções',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditUser(),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit_note,
                      ),
                      Text('Editar Perfil'),
                    ],
                  ),
                ),
                Visibility(
                  visible: user?.typeProfile == 'worker',
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectCategory(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text('Editar Categoria'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditAddress(),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.map_outlined,
                        size: 20,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text('Editar Endereço'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    var authProvider = context.read<AuthServiceProvider>();

                    authProvider.signOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text('Sair do aplicativo'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Center(
              child: Text(
                'Versão do aplicativo: 1.0.0',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceList extends StatelessWidget {
  const ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthServiceProvider>().loggedUser;

    List<String> services = [];

    for (var element in user!.services!) {
      services.add(element.title);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Serviços Disponíveis',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: services
              .map(
                (service) => Column(
                  children: [
                    Text(service),
                    const SizedBox(
                      height: 8.0,
                    )
                  ],
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
