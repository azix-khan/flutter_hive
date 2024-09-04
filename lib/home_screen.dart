// ignore_for_file: avoid_print

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
        title: const Text("Notes with Hive Database"),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
