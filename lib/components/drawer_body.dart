import 'package:app/application_constants.dart';
import 'package:app/navigator/application_routes.dart';
import 'package:flutter/material.dart';

class DrawerBody extends StatefulWidget {
  final AnimationController animationController;
  const DrawerBody({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  _toggleAnimation() {
    widget.animationController.isDismissed
        ? widget.animationController.forward()
        : widget.animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 36),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/eu.png'),
                    radius: 35,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Rúben Machado',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'ruben.xb@hotmail.com',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: () => _toggleAnimation(),
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.wallet,
                          color: Colors.black54,
                        ),
                      ),
                      title: const Text(
                        'Carteira',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          color: Colors.black54,
                        ),
                      ),
                      title: const Text(
                        'Encomendas',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.black54,
                        ),
                      ),
                      title: const Text(
                        'Favoritos',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.contact_page_sharp,
                          color: Colors.black54,
                        ),
                      ),
                      title: const Text(
                        'Contactos',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ApplicationRoutes.aboutUsScreen);
                      },
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.people_sharp,
                          color: Colors.black54,
                        ),
                      ),
                      title: const Text(
                        'Sobre Nós',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.black54,
                        ),
                      ),
                      title: const Text(
                        'Definições',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                      ),
                      title: const Text(
                        'Terminar Sessão',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Garbo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
