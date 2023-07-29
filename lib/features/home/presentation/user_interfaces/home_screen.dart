import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/core/constants/application_constants.dart';
import 'package:app/core/components/carousel_slider.dart';
import 'package:app/features/home/presentation/components/drawer_body.dart';
import 'package:app/core/data/models/item_model.dart';
import 'package:app/core/navigator/application_routes.dart';
import 'package:app/features/auth/presentation/business_components/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final authCubit = CubitFactory.authCubit;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  _toggleAnimation() {
    _animationController!.isDismissed
        ? _animationController!.forward()
        : _animationController!.reverse();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _navigateToAuthScreen() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(ApplicationRoutes.authScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery.of(context).size.width * 0.5;

    return BlocConsumer<AuthCubit, AuthStatus>(
      bloc: authCubit,
      listener: (context, state) {
        // TODO: implement listener
        if (state == AuthStatus.unauthenticated) {
          _navigateToAuthScreen();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              double right = rightSlide * _animationController!.value;
              double scale = 1 - (_animationController!.value * 0.3);
              return Stack(
                children: [
                  //Drawer
                  Scaffold(
                    backgroundColor: Colors.white,
                    body: DrawerBody(
                      animationController: _animationController!,
                    ),
                  ),
                  //Main Screen
                  GestureDetector(
                    onTap: () {
                      if (_animationController!.isCompleted) {
                        _toggleAnimation();
                      }
                    },
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(right, 0.0, 0.0)
                        ..scale(scale),
                      alignment: Alignment.center,
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _animationController!.isDismissed ? 0 : 20.0),
                        ),
                        child: Scaffold(
                          key: _key,
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            leading: IconButton(
                              onPressed: () => _toggleAnimation(),
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black54,
                              ),
                            ),
                            title: const Text(
                              'Garbo',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            centerTitle: true,
                            actions: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          body: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Alguns artigos',
                                  style: TextStyle(
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Text('Vários desportos',
                                    style: TextStyle(fontSize: 22)),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                GarboSlider(items: firstSliderMocks),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Text(
                                  'Sport Wear',
                                  style: TextStyle(fontSize: 22),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                GarboSlider(items: secondSliderMocks),
                                const Text(
                                  'Bordados, transfers e serigrafia disponíveis em todos os artigos',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
