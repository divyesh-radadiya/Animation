import 'package:flutter/material.dart';
import 'page2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> myList = ['a', 'b', 'c'];
  final _animatedKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    var begin = Offset(3.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return Scaffold(
        appBar: AppBar(
          title: Text('List'),
        ),
        body: AnimatedList(
          key: _animatedKey,
          initialItemCount: myList.length,
          itemBuilder: (context, index, animation) {
            return SlideTransition(
              position: animation.drive(tween),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.black12,
                  title: Text(myList[index]),
                ),
              ),
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              child: Icon(Icons.subdirectory_arrow_right_outlined),
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
            FloatingActionButton(
              heroTag: "btn2",
              child: Icon(Icons.plus_one),
              onPressed: () {
                myList.insert(1, 'z');
                _animatedKey.currentState.insertItem(1);
              },
            ),
            FloatingActionButton(
              heroTag: "btn3",
              child: Icon(Icons.exposure_minus_1),
              onPressed: () {
                myList.removeAt(1);
                _animatedKey.currentState.removeItem(
                    1,
                    (context, animation) => SizeTransition(
                          sizeFactor: animation,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Colors.black12,
                              title: Text(myList[1]),
                            ),
                          ),
                        ));
              },
            )
          ],
        ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        OpenContainerTransformDemo(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
