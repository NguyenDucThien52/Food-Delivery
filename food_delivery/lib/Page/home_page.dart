import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Placeholder();
      case 1:
        page = Placeholder();
      case 2:
        page = Placeholder();
      case 3:
        page = Placeholder();
      case 4:
        page = Placeholder();
      case 5:
        page = Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    var mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    // var appState = context.watch<MyAppState>();
    return Scaffold(
      body: LayoutBuilder(
        builder: (contex, covariant) {
          return Column(
            children: [
              Expanded(child: mainArea),
              SafeArea(
                top: false,
                bottom: false,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  fixedColor: Theme.of(context).colorScheme.primary,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Trang chủ",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart),
                      label: "Đặt hàng",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.store),
                      label: "Cửa hàng",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.card_giftcard),
                      label: "Ưu đãi",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list_outlined),
                      label: "Khác",
                      // backgroundColor: Colors.lightGreen,
                    ),
                  ],
                  currentIndex: selectedIndex,
                  onTap: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
