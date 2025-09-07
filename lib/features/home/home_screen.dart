import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.list), label: '목록'),
          NavigationDestination(icon: Icon(Icons.settings), label: '설정'),
        ],
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go('/home'); break;
            case 1: context.go('/list'); break;
            case 2: context.go('/settings'); break;
          }
        },
        selectedIndex: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) => Card(
          child: ListTile(
            title: Text('카드 $i'),
            subtitle: const Text('더미 콘텐츠 • 터치하면 상세로 이동'),
            onTap: () => context.go('/detail'),
          ),
        ),
      ),
    );
  }
}