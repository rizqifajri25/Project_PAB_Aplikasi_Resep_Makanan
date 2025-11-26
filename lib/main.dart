import 'package:flutter/material.dart';
import 'package:wisata_candi/screens/favorite_screen.dart';
import 'package:wisata_candi/screens/home_screen.dart';
import 'package:wisata_candi/screens/search_screen.dart';
import 'package:wisata_candi/screens/profile_screen.dart';
import 'package:wisata_candi/screens/signUpScreen.dart';
import 'package:wisata_candi/screens/SignInScreen.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/screens/detail_screen.dart';
import 'widgets/profile_info_item.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wisata Candi',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.deepPurple),
            titleTextStyle: TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme:
          ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
            primary: Colors.deepPurple,
            surface: Colors.deepPurple[50],
          ),
          useMaterial3: true,
        ),
        // initialRoute: '/',
        // routes: {
        //   '/homescreen': (context) => const MainScreen(),
        //   '/signin': (context) => const SignInScreen(),
        //   '/signup': (context) => const SignUpScreen(),
        // }
      home : const MainScreen(),
      routes: {
          '/signin' : (context) => const SignInScreen(),
          '/signup' : (context) => const SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // TODO: 1. Deklarasi variabel
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    // SignUpScreen(),
    // SignInScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   TODO: 2. Buat properti body berupa widget yang ditampilkan
      body: _children[
      _currentIndex
      ],
      //   TODO: 3. Buat properti bottomNavigationBar dengan nilai Theme
      bottomNavigationBar: Theme(
        //   TODO: 4. Buat data dan child dari Theme
        data: Theme.of(context).copyWith(
          canvasColor: Colors.deepPurple[50],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon:
            Icon(Icons.home,
                color: Colors.deepPurple
            ),
                label: 'Home'
            ),
            BottomNavigationBarItem(icon:
            Icon(Icons.search,
                color: Colors.deepPurple
            ),
                label: 'Search'
            ),
            BottomNavigationBarItem(icon:
            Icon(Icons.favorite,
                color: Colors.deepPurple
            ),
                label: 'Favorite'
            ),
            BottomNavigationBarItem(icon:
            Icon(Icons.person,
                color: Colors.deepPurple
            ),
                label: 'Profile'
            ),
          ],
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.deepPurple[100],
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}