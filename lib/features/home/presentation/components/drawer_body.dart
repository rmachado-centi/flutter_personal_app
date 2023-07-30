import 'package:app/core/blocs/application_state.dart';
import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/core/constants/application_constants.dart';
import 'package:app/core/data/models/user_model.dart';
import 'package:app/core/navigator/application_routes.dart';
import 'package:app/features/home/presentation/business_components/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerBody extends StatefulWidget {
  final AnimationController animationController;
  const DrawerBody({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  final homeCubit = CubitFactory.homeCubit;

  UserModel? user;

  _toggleAnimation() {
    widget.animationController.isDismissed
        ? widget.animationController.forward()
        : widget.animationController.reverse();
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void _navigateToAuthScreen() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(ApplicationRoutes.authScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ApplicationState>(
      bloc: homeCubit,
      listener: (context, state) {
        if (state is HomeSignOutSuccessState) {
          _navigateToAuthScreen();
        }
      },
      builder: (context, state) {
        if (state is HomeUserDataSuccessState) {
          user = state.user;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 36),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: false,
                        child: CircleAvatar(
                          foregroundImage: NetworkImage(user?.imageUrl ?? ''),
                          radius: 35,
                          child: Text(
                            user?.name?.substring(0, 1) ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              user?.email ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
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
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ApplicationRoutes.contactsScreen);
                          },
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
                          onTap: () => homeCubit.signOut(),
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
      },
    );
  }

  void getUserData() async {
    homeCubit.getHomeData();
  }
}
