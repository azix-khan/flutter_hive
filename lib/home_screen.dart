import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Box>? _boxFuture;
  Future<Box>? _box2Future;

  @override
  void initState() {
    super.initState();
    _boxFuture = Hive.openBox('database');
    _box2Future = Hive.openBox('database2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hive"),
      ),
      body: Column(
        children: [
          FutureBuilder<Box>(
            future: _boxFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // for box
                final box = snapshot.data!;
                return Column(
                  children: [
                    // for box 1
                    Center(
                      child: ListTile(
                        title: Text(box.get('name').toString()),
                        subtitle: Text(box.get('age').toString()),
                        trailing: IconButton(
                            onPressed: () {
                              box.put('name', 'azix khan');
                              box.put('age', 19);
                              setState(() {});
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No data found'));
              }
            },
          ),
          // for box2
          FutureBuilder<Box>(
            future: _box2Future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final box2 = snapshot.data!;
                return Column(
                  children: [
                    Center(
                      child: ListTile(
                        title: Text(box2.get('file').toString()),
                        subtitle: Text(box2.get('data').toString()),
                        trailing: IconButton(
                            onPressed: () {
                              box2.delete('file');
                              box2.delete('data');
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No data found'));
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('database');
          var box2 = await Hive.openBox('database2');

          box2.put('file', 'file1');
          box2.put('data', 'file1 data');

          box.put('name', 'azix');
          box.put('age', 20);
          box.put('details',
              {'passion': 'software engineering', 'profession': 'developer'});
          print(box.get('name'));
          print(box.get('age'));
          print(box.get('details'));
          print(box.get('details')['passion']);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
