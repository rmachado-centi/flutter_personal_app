import 'package:app/core/blocs/application_state.dart';
import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/core/components/custom_scaffold.dart';
import 'package:app/core/data/models/item/item_model.dart';
import 'package:app/core/data/models/user_model.dart';
import 'package:app/core/utils/scroll_listener.dart';
import 'package:app/features/home/presentation/business_components/home_cubit.dart';
import 'package:app/core/navigator/application_routes.dart';
import 'package:app/features/home/presentation/components/drawer_body.dart';
import 'package:app/features/home/presentation/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final homeCubit = CubitFactory.homeCubit;
  final ScrollController _controller = ScrollController();
  final double _bottomNavBarHeight = 72;
  late final ScrollListener _model;
  final items = List<Item>.generate(
    10,
    (index) => Item(
        name: 'Dignissim convallis aenaea',
        image: 'assets/images/mock_image.jpg',
        price: 19.99,
        id: '1'),
  );

  late bool _showCartBadge;
  UserModel? user;

  int _totalCartItems = 0;

  void getUserData() {
    homeCubit.getHomeData();
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    _model = ScrollListener.initialise(_controller);
    getUserData();
    homeCubit.updateCartTotalItems();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _model.dispose();
    super.dispose();
  }

  void _navigateToAuthScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(ApplicationRoutes.authScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    _showCartBadge = _totalCartItems > 0;

    return BlocConsumer<HomeCubit, ApplicationState>(
      bloc: homeCubit,
      listener: (context, state) {
        switch (state.runtimeType) {
          case HomeSignOutSuccessState:
            _navigateToAuthScreen();
            break;
          case HomeAddToCartSuccessState:
            homeCubit.updateCartTotalItems();
            break;
          case HomeGetTotalCartItemsState:
            setState(() {
              _totalCartItems = (state as HomeGetTotalCartItemsState).num;
            });
            break;
        }
      },
      builder: (context, state) {
        if (state is HomeUserDataSuccessState) {
          user = state.user;
        }

        return CustomScaffold(
          scaffoldKey: _key,
          title: 'Garbo',
          drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: DrawerBody(
            user: user,
            onSignOutConfirm: () => homeCubit.signOut(),
          )),
          leading: IconButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.amber[800],
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0),
              child: _shoppingCartBadge(),
            ),
          ],
          body: AnimatedBuilder(
              animation: _model,
              builder: (BuildContext context, child) {
                return Stack(
                  children: [
                    GridView.builder(
                      controller: _controller,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.4 / 0.6,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        var item = items[index];
                        return ItemCard(
                          item: item,
                          onPressed: () {
                            homeCubit.addToCart(item);
                          },
                        );
                      },
                      itemCount: items.length,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: _model.bottom,
                      child: _bottomNavBar,
                    )
                  ],
                );
              }),
        );
      },
    );
  }

  Widget get _bottomNavBar {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      height: _bottomNavBarHeight,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          shape: const CircleBorder(side: BorderSide.none),
          backgroundColor: Colors.amber[800],
        ),
        child: const Icon(
          Icons.filter_list,
          size: 36,
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(ApplicationRoutes.cartScreen);
        if (mounted) {
          homeCubit.updateCartTotalItems();
        }
      },
      child: badges.Badge(
        showBadge: _showCartBadge,
        ignorePointer: false,
        badgeContent: Text(
          _totalCartItems.toString(),
        ),
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.circle,
          badgeColor: Colors.amber,
          padding: EdgeInsets.all(6),
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.white, width: 2),
          elevation: 0,
        ),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.amber[800],
          size: 26,
        ),
      ),
    );
  }
}
