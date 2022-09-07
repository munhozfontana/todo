import 'package:flutter/material.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  late TabController tabController;

  @override
  void initState() {
    pageController = PageController();
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  void nextPage() {
    if ((tabController.index + 1) < tabController.length) {
      tabController.animateTo(tabController.index + 1);
      pageController.animateToPage(
        tabController.index,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    } else {
      print('to home');
    }
  }

  void backPage() {
    if (tabController.index > 0) {
      tabController.animateTo(tabController.index - 1);
      pageController.animateToPage(
        tabController.index,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.vertical,
            controller: pageController,
            children: [
              Image.asset(
                'assets/exe.png',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/exe.png',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/exe.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
          Opacity(
            opacity: .5,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromARGB(255, 41, 41, 41),
                    Color.fromARGB(255, 0, 0, 0),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .95),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.small(
                    onPressed: backPage,
                    child: const Icon(Icons.navigate_before_outlined),
                  ),
                  TabPageSelector(
                    indicatorSize: 24,
                    controller: tabController,
                  ),
                  FloatingActionButton.small(
                    onPressed: nextPage,
                    child: const Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
