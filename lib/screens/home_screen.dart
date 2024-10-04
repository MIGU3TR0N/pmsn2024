import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024/screens/profile_screen.dart';
import 'package:pmsn2024/settings/colors_settings.dart';
import 'package:pmsn2024/settings/global_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int v_index = 0;
  final _key = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.access_alarm)),
          GestureDetector(
            onTap: (){},
            child: 
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Image.asset('assets/cs_icon.png')
            )
          ),
        ],
      ),
      body: Builder(builder: (context){
        switch (v_index){
          case 1: return ProfileScreen();
          default: return Text('home');
        }
      }),
      //endDrawer: Drawer(),
      drawer: myDrawer(),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        backgroundColor: Colors.deepOrange,
        onTap: (index) => setState(() {
          v_index = index;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            child: const Icon(Icons.light_mode),
            onPressed: () {
              GlobalValues.banThemeDark.value = false;
            },
          ),
          FloatingActionButton.small(
            child: const Icon(Icons.dark_mode),
            onPressed: () {
              GlobalValues.banThemeDark.value = true;
            },
          ),
        ]
      ),
    );
  }
  Widget myDrawer(){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            accountName: Text('Jesus Miguel Cerda Gonzalez'), 
            accountEmail: Text('cerda.gonzalez.jesus@gmail.com')
          ),
          ListTile(
            onTap: ()=>Navigator.pushNamed(context, '/db'),
            title: Text('Movies List'),
            subtitle: Text('Database of movies'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: ()=>Navigator.pushNamed(context, '/popular'),
            title: Text('Popular Movies'),
            subtitle: Text('API of movies'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}