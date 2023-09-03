import 'package:flutter/material.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isEditing = false;
  /// create a new list of data
  final items = List<int>.generate(40, (index) => index);

  /// when the reorder completes remove the list entry from its old position
  /// and insert it at its new index
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ReorderableGridView.extent(
          maxCrossAxisExtent: 150,
          onReorder: _onReorder,
          onReorderStarted: (){
            print('Reorder started');
          },
          childAspectRatio: 1,
          proxyDecorator: (widget, index, animation) {
            final scale = Tween<double>(begin: 1, end: 1.1).animate(animation);
            return ScaleTransition(scale: scale, child: widget);
          },
          children: items.map((item) {
            /// map every list entry to a widget and assure every child has a
            /// unique key
            return Card(
              key: ValueKey(item),
              child: Center(
                child: Text(item.toString()),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
