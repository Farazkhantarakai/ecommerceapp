import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:ecommerce_app/dummy_data.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
import 'package:ecommerce_app/screens/authservices/loginscreen.dart';
import 'package:ecommerce_app/screens/authservices/signupscreen.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/chatscreen.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:ecommerce_app/screens/favouritescreen.dart';
import 'package:ecommerce_app/screens/getstaretedScreen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: CartItem(),
          )
        ],
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: auth.isAuth ? const MyHomeApp() : const LogInScreen(),
              routes: {
                HomeScreen.routName: (context) => const HomeScreen(),
                GetStartedScreen.routName: (context) =>
                    const GetStartedScreen(),
                DetailScreen.routName: (context) => const DetailScreen(),
                SignUpScreen.routName: (context) => const SignUpScreen(),
                LogInScreen.routName: (context) => const LogInScreen(),
              },
            );
          },
        ));
  }
}

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key});

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var item = Provider.of<CartItem>(context).getCartItem;

    return CurvedNavBar(
        actionButton: CurvedActionBar(
            onTab: (value) {
              if (kDebugMode) {
                print(value);
              }
            },
            activeIcon: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  constraints:
                      const BoxConstraints.expand(width: 70, height: 70),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Color.fromARGB(255, 120, 199, 252),
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 7,
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${item.length}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )),
              ],
            ),
            inActiveIcon: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  constraints:
                      const BoxConstraints.expand(width: 70, height: 70),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Color.fromARGB(255, 120, 199, 252),
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 7,
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${item.length}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )),
              ],
            ),
            text: ""),
        activeColor: Colors.blue,
        // navBarBackgroundColor: Colors.white,
        inActiveColor: Colors.black45,
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.home,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.home,
                color: Colors.black26,
              ),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.favorite,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.favorite,
                color: Colors.black26,
              ),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.book,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.book,
                color: Colors.black26,
              ),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.person,
                color: Colors.blue,
              ),
              inActiveIcon: const Icon(
                Icons.person,
                color: Colors.black26,
              ),
              text: ''),
        ],
        bodyItems: const [
          HomeScreen(),
          FavouriteScreen(),
          ChatScreen(),
          ProfileScreen()
        ],
        actionBarView: Cart(
          key: UniqueKey(),
        ));
  }
}