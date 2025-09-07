import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상세')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Placeholder(fallbackHeight: 160),
            const SizedBox(height: 12),
            Text('상세 제목', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text('이곳에 상세 설명(더미)이 들어갑니다. 서버 없이 UX 확인용.'),
          ],
        ),
      ),
    );
  }
}