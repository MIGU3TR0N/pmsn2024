import 'package:flutter/material.dart';
import 'package:pmsn2024/settings/colors.dart';
import 'package:pmsn2024/settings/drink.dart';
import 'drinkCard.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController pageController;
  double pageOffset = 0;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildToolbar(),
            buildLogo(size),
            buildPager(size),
            buildPageIndecator()
          ],
        ),
      ),
    );
  }

  Widget buildToolbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                  offset: Offset(-200 * (1 - animation.value).toDouble(), 0),
                  child: Image.asset(
                    'assets/location.png',
                    width: 30,
                    height: 30,
                  ),
                );
              }),
          const Spacer(),
          AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                  offset: Offset(200 * (1 - animation.value).toDouble(), 0),
                  child: Image.asset(
                    'assets/drawer.png',
                    width: 30,
                    height: 30,
                  ),
                );
              }),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform(
              transform: Matrix4.identity()
                ..translate(0.0, size.height / 2 * (1 - animation.value))
                ..scale(1 + (1 - animation.value)),
              origin: const Offset(25, 25),
              child: InkWell(
                onTap: () => controller.isCompleted
                    ? controller.reverse()
                    : controller.forward(),
                child: Image.asset(
                  'assets/cs2logo.png',
                  width: 50,
                  height: 50,
                ),
              ),
            );
          }),
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(400 * (1 - animation.value).toDouble(), 0),
              child: PageView.builder(
                  controller: pageController,
                  itemCount: getDrinks().length,
                  itemBuilder: (context, index) =>
                      DrinkCard(getDrinks()[index], pageOffset, index)),
            );
          }),
    );
  }

  List<Drink> getDrinks() {
    List<Drink> list = [];
    list.add(Drink(
        'Todo o',
        ' nada',
        'assets/blur_cs.jpg',
        'assets/smoke.png',
        'assets/grenade.png',
        'assets/graffiti2.png',
        'assets/awp.png',
        'En nuestro casino cs ReRoll obten la skin de tu sueños \nPara presumir en tus partidas',
        mPinkLight,
        mPink));
    list.add(Drink(
        'Recom',
        'pensas',
        'assets/blur_cs_blue.jpg',
        'assets/smoke.png',
        'assets/incgrenade.png',
        'assets/graffiti.png',
        'assets/ak47.png',
        'Una bonificacion del 5% \nen cada deposito\n+ recompesas diarias.',
        blueLight,
        blueDark));
    list.add(Drink(
        'Eventos ',
        'al mes',
        'assets/blur_cs_red.jpg',
        'assets/grenade.png',
        'assets/smoke.png',
        'assets/graffiti3.png',
        'assets/p250.png',
        'Contamos con eventos tematicos mensuales \ncon aumentos de probabilidad de salida de esas skins especiales.',
        redLight,
        redDark));
    return list;
  }

  Widget buildPageIndecator() {
    return AnimatedBuilder(
      animation:controller,
      builder: (context, snapshot) {
        return Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: controller.value,
            child: Row(
              children:
                  List.generate(getDrinks().length, (index) => buildContainer(index)),
            ),
          ),
        );
      }
    );
  }

  Widget buildContainer(int index) {
    double animate =pageOffset-index;
    double size =10;
    animate=animate.abs();
    Color? color =Colors.grey;
    if(animate<=1 && animate>=0){
      size=10+10*(1-animate);
      color =ColorTween(begin: Colors.grey,end: mAppGreen).transform((1-animate));
    }

    return Container(
      margin: const EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}