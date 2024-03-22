import 'package:app/consts/profile.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderHome extends StatelessWidget implements PreferredSizeWidget {
  const HeaderHome({super.key});

  void handleSignOut(BuildContext context) {
    var authProvider = context.read<AuthServiceProvider>();

    authProvider.signOut();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20.0);

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthServiceProvider>();

    var user = authProvider.loggedUser;

    return AppBar(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      user != null
                          ? user.avatarUrl ?? ProfileConst.avatarUrl
                          : ProfileConst.avatarUrl,
                    ),
                    radius: 24,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bem-Vindo',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        user != null
                            ? user.name
                            : 'Visitante',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 32.0,
                  color: Colors.white,
                ),
                onPressed: () => handleSignOut(context),
              ),
            ],
          ),
        ],
      ),
      toolbarHeight: 80.0,
      backgroundColor: Colors.deepOrangeAccent,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      leading: null,
    );
  }
}
