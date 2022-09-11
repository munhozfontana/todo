import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/ui/widgets/btn_round_widget.dart';
import 'package:todo/app/ui/widgets/tutorial/hole_pointer.dart';
import 'package:tutorial/tutorial.dart';

class HomePageTutorial extends StatefulWidget {
  const HomePageTutorial({Key? key}) : super(key: key);

  @override
  State<HomePageTutorial> createState() => _HomePageTutorialState();
}

class _HomePageTutorialState extends State<HomePageTutorial> {
  final appBarMenu = GlobalKey();
  final inputKey = GlobalKey();
  final addKey = GlobalKey();
  final cleanKey = GlobalKey();
  final itemKey = GlobalKey();
  final deleteKey = GlobalKey();

  List<TutorialItem> items = [];

  int itemSelect = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: appBar(context),
          body: body(size, context),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: appTutorial(size, context),
        )
      ],
    );
  }

  Widget appTutorial(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          itemSelect++;
          if (itemSelect >= 6) {
            GoRouter.of(context).go('/home');
          }
        });
      },
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.transparent,
        child: Stack(
          children: [
            buildItem(
              text: "Here are you have possible to open the Menu",
              key: appBarMenu,
              show: itemSelect == 0,
            ),
            buildItem(
              text: "Here you write the name of your todo",
              key: inputKey,
              show: itemSelect == 1,
            ),
            buildItem(
              text:
                  "When you click, are you go to new Todo and if are Press created the todo and permanence at screen",
              key: addKey,
              show: itemSelect == 2,
            ),
            buildItem(
              text: "Here are have possible to clean the field",
              key: cleanKey,
              show: itemSelect == 3,
            ),
            buildItem(
              text: "Here are have possible to see the info",
              key: itemKey,
              show: itemSelect == 4,
            ),
            buildItem(
              text: "This button remove item",
              key: deleteKey,
              show: itemSelect == 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      {required String text,
      required GlobalKey<State<StatefulWidget>> key,
      show = false}) {
    if (!show) {
      return const SizedBox.shrink();
    }
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CustomPaint(
          size: size,
          painter: HolePainter(
            key: key,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Tap to continue',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding body(Size size, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .10,
      ),
      child: Stack(
        children: [
          listTodo(),
          form(size, context),
        ],
      ),
    );
  }

  Align form(Size size, BuildContext context) {
    return Align(
      alignment: const Alignment(-1.0, .85),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
              )
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.2)
              ],
              stops: const [0.0, 1.0],
            ),
            borderRadius: BorderRadius.circular(50)),
        height: size.height * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 24),
            Expanded(
              key: inputKey,
              flex: 9,
              child: const TextField(),
            ),
            const SizedBox(width: 12),
            BtnRoundWidget(
              key: addKey,
              color: Theme.of(context).primaryColor,
              child: const Center(
                  child: Icon(
                Icons.add,
              )),
            ),
            const SizedBox(width: 12),
            BtnRoundWidget(
              key: cleanKey,
              color: Colors.blueGrey,
              child: const Icon(Icons.clear),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  Widget listTodo() {
    return ListView(
      children: [
        ListTile(
          key: itemKey,
          title: const Text('My First Todo'),
          trailing: InkWell(
            key: deleteKey,
            child: const Icon(Icons.delete),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: [
        SizedBox(
          width: 50,
          child: InkWell(
            key: appBarMenu,
            child: const Icon(
              Icons.live_help_outlined,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
