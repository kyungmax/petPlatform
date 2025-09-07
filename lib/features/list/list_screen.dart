import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('목록')),
      body: RefreshIndicator(
        onRefresh: () async => await Future.delayed(const Duration(milliseconds: 600)),
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (_, i) => ListTile(
            leading: const CircleAvatar(child: Icon(Icons.image)),
            title: Text('아이템 $i'),
            subtitle: const Text('로컬 더미 데이터'),
            onTap: () => context.go('/detail'),
          ),
        ),
      ),
    );
  }
}