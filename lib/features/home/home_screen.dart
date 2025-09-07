import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            // 로고 (asset 대체 가능)
            Image.asset(
              'assets/logo_camfit.png', // ← 로고 에셋 경로로 교체
              height: 24,
              errorBuilder: (_, __, ___) => Text(
                'PET PLATFORM',
                style: TextStyle(
                  color: const Color(0xFF27C187),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: const StadiumBorder(),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              onPressed: () {
                // 예약조회 클릭 모사
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('예약조회(프로토타입)')));
              },
              child: const Text('예약조회'),
            ),
          ),
        ],
      ),

      // 하단탭(기존과 동일 동작)
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/list');
              break;
            case 2:
              context.go('/settings');
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: '홈'),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            label: '목록',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: '설정',
          ),
        ],
      ),

      body: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) 상단 프로모 배너
            _FestivalBanner(),

            const SizedBox(height: 16),

            // 2) 카테고리 그리드 (아이콘 + 라벨, NEW 뱃지 포함)
            _CategoryGrid(),

            const SizedBox(height: 16),

            // 3) 예약오픈 일정 한눈에 (작은 CTA 카드)
            _SmallCTA(
              leadingIcon: Icons.event_available_outlined,
              title: '숙소 예약오픈 일정 한눈에 보기',
              subtitle: '오픈 일정이 궁금하신가요?',
              onTap: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('예약오픈 일정 보기(모사)'))),
            ),

            const SizedBox(height: 20),

            // 4) 섹션 헤더
            _SectionHeader(
              title: '실시간 캠핑 로그',
              actionText: '전체보기',
              onTap: () {
                // 전체보기 → 목록으로 이동 모사
                context.go('/list');
              },
            ),

            const SizedBox(height: 8),

            // 5) 캠핑 로그 리스트 (이미지 + 텍스트)
            _LogList(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------- 컴포넌트들 ---------------------------- */

class _FestivalBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer.withOpacity(0.35), cs.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '영월군 야영장 연합회',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: cs.primary),
                ),
                const SizedBox(height: 6),
                Text(
                  '영월 캠핑 페스티벌 개최',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '기간 │ 2025년 7월~9월\n장소 │ 영월군 소재 야영장 15개소',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // 원형 일러스트 (asset 대체)
          CircleAvatar(
            radius: 36,
            backgroundColor: cs.primary.withOpacity(0.08),
            backgroundImage: const AssetImage(
              'assets/banner_camping.png', // ← 배너 일러스트 경로
            ),
            onBackgroundImageError: (_, __) {},
          ),
        ],
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  _CategoryGrid({super.key});

  final _items = [
    _Cat('안심취소', 'assets/cat_secure.png', isNew: true),
    _Cat('온가족캠핑', 'assets/cat_family.png'),
    _Cat('타프존캠핑', 'assets/cat_tarp.png'),
    _Cat('키즈캠핑', 'assets/cat_kids.png'),
    _Cat('반려견동반', 'assets/cat_pet.png'),
    _Cat('이지캠핑', 'assets/cat_easy.png'),
    _Cat('오토캠핑', 'assets/cat_auto.png'),
    _Cat('글램핑', 'assets/cat_glamping.png'),
    _Cat('카라반', 'assets/cat_caravan.png'),
    _Cat('펜션', 'assets/cat_pension.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelSmall;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // 2줄 x 5칸
        mainAxisExtent: 92,
      ),
      itemBuilder: (context, i) {
        final it = _items[i];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      it.iconPath, // 아이콘 에셋 경로
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.park_outlined),
                    ),
                  ),
                ),
                if (it.isNew) Positioned(top: -6, left: -6, child: _NewBadge()),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 70,
              child: Text(
                it.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: cs.error,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'NEW',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: cs.onError,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _SmallCTA extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SmallCTA({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(leadingIcon, size: 22, color: cs.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.title,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              actionText,
              style: TextStyle(color: cs.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _LogList extends StatelessWidget {
  _LogList({super.key});

  final _logs = List.generate(
    6,
    (i) => _LogItem(
      title: '친절한 캠지기분과 멋진 뷰는 선물같았습니다. 너무 깨끗한 부대시설도 기분좋게했구요. 또가고싶은 캠장입니다',
      timeAgo: '${40 + i}분 전',
      imagePath: 'assets/log_$i.jpg', // ← 썸네일 에셋 경로
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _logs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final log = _logs[i];
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              // 썸네일
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: SizedBox(
                  width: 100,
                  height: 76,
                  child: Image.asset(
                    log.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.black12,
                      child: const Icon(Icons.image),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // 텍스트
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        log.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        log.timeAgo,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/* --------------------------- 모델/헬퍼 --------------------------- */

class _Cat {
  final String label;
  final String iconPath;
  final bool isNew;
  _Cat(this.label, this.iconPath, {this.isNew = false});
}

class _LogItem {
  final String title;
  final String timeAgo;
  final String imagePath;
  _LogItem({
    required this.title,
    required this.timeAgo,
    required this.imagePath,
  });
}
