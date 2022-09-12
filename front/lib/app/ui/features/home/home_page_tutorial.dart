import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final itemKey = GlobalKey();
  final deleteKey = GlobalKey();
  final editKey = GlobalKey();

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

  Padding body(Size size, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .20,
      ),
      child: Column(
        children: [
          form(size, context),
          const SizedBox(height: 18),
          listTodo(size),
        ],
      ),
    );
  }

  Widget form(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      height: size.height * .05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              key: inputKey,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              key: addKey,
              onPressed: () => print(''),
              child: const Text('Create'),
            ),
          ),
        ],
      ),
    );
  }

  Widget listTodo(size) {
    return SizedBox(
      height: size.height * .5,
      child: ListView(
        children: [
          ListTile(
            key: itemKey,
            tileColor: Colors.grey[200],
            title: const Text('Todo 1'),
            trailing: SizedBox(
              height: double.maxFinite,
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      key: editKey,
                      child: const Icon(
                        Icons.edit,
                        size: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      key: deleteKey,
                      child: const Icon(
                        Icons.delete,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            tileColor: Colors.grey[200],
            title: const Text('Todo 1'),
            trailing: SizedBox(
              height: double.maxFinite,
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: InkWell(
                      child: Icon(
                        Icons.edit,
                        size: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Icon(
                        Icons.delete,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            tileColor: Colors.grey[200],
            title: const Text('Todo 1'),
            trailing: SizedBox(
              height: double.maxFinite,
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: InkWell(
                      child: Icon(
                        Icons.edit,
                        size: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Icon(
                        Icons.delete,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: [
        SizedBox(
          key: appBarMenu,
          width: 50,
          child: InkWell(
            onTap: () => GoRouter.of(context).push('/about_app_page'),
            child: const Icon(
              Icons.live_help_outlined,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }

// ----------------

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
              text: "Here are have possible to see the info",
              key: itemKey,
              show: itemSelect == 3,
            ),
            buildItem(
              text: "This button remove item",
              key: deleteKey,
              show: itemSelect == 4,
            ),
            buildItem(
              text: "Here ou navigate to edit page",
              key: editKey,
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
}
