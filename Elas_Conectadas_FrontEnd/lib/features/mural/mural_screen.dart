import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class MuralScreen extends StatefulWidget {
  const MuralScreen({super.key});

  @override
  State<MuralScreen> createState() => _MuralScreenState();
}

class _MuralScreenState extends State<MuralScreen> {
  String _filter = 'Todos';
  final _filters = ['Todos', 'Eventos', 'Cursos'];

  final _mockPosts = [
    const _PostItem(
        emoji: '🎤',
        title: 'Summit Mulheres em Tech',
        type: 'EVENT',
        date: '15 Abr 2026',
        interested: 38,
        isHero: true,
        description:
            'Maior encontro de mulheres da tecnologia do Brasil. Palestras, workshops e muito networking!'),
    const _PostItem(
        emoji: '📊',
        title: 'Curso: Finanças para Empreendedoras',
        type: 'COURSE',
        date: '22 Abr 2026',
        interested: 21,
        isHero: false,
        description:
            'Aprenda a gerir o seu negócio com inteligência financeira.'),
    const _PostItem(
        emoji: '🌿',
        title: 'Encontro de Negócios Sustentáveis',
        type: 'EVENT',
        date: '29 Abr 2026',
        interested: 14,
        isHero: false,
        description:
            'Negócios com propósito e impacto socioambiental positivo.'),
    const _PostItem(
        emoji: '🎨',
        title: 'Curso: Branding para MEI',
        type: 'COURSE',
        date: '05 Mai 2026',
        interested: 9,
        isHero: false,
        description: 'Como criar uma marca forte com poucos recursos.'),
  ];

  List<_PostItem> get _filtered {
    if (_filter == 'Todos') return _mockPosts;
    if (_filter == 'Eventos')
      return _mockPosts.where((p) => p.type == 'EVENT').toList();
    return _mockPosts.where((p) => p.type == 'COURSE').toList();
  }

  @override
  Widget build(BuildContext context) {
    final posts = _filtered;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mural de Oportunidades'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _filters
                  .map((f) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(f),
                          selected: _filter == f,
                          onSelected: (_) => setState(() => _filter = f),
                          selectedColor: AppColors.textWhite,
                          backgroundColor: AppColors.primaryLight,
                          labelStyle: AppTextStyles.labelMedium.copyWith(
                            color: _filter == f
                                ? AppColors.primary
                                : AppColors.textMedium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (_, i) => posts[i].isHero
            ? _HeroPostCard(post: posts[i])
            : _SmallPostCard(post: posts[i]),
      ),
    );
  }
}

class _HeroPostCard extends StatefulWidget {
  final _PostItem post;
  const _HeroPostCard({required this.post});

  @override
  State<_HeroPostCard> createState() => _HeroPostCardState();
}

class _HeroPostCardState extends State<_HeroPostCard> {
  late int _count;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    _count = widget.post.interested;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Capa hero
          Container(
            height: 160,
            width: double.infinity,
            color: AppColors.primaryLight,
            child: Center(
                child: Text(widget.post.emoji,
                    style: const TextStyle(fontSize: 64))),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TypeBadge(type: widget.post.type),
                const SizedBox(height: 8),
                Text(widget.post.title, style: AppTextStyles.titleLarge),
                const SizedBox(height: 4),
                Text(widget.post.description,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(widget.post.date, style: AppTextStyles.labelMedium),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => setState(() {
                        _liked = !_liked;
                        _count += _liked ? 1 : -1;
                      }),
                      child: Row(
                        children: [
                          Icon(_liked ? Icons.favorite : Icons.favorite_border,
                              color: _liked ? Colors.red : AppColors.textLight,
                              size: 18),
                          const SizedBox(width: 4),
                          Text('$_count interessadas',
                              style: AppTextStyles.labelMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallPostCard extends StatefulWidget {
  final _PostItem post;
  const _SmallPostCard({required this.post});

  @override
  State<_SmallPostCard> createState() => _SmallPostCardState();
}

class _SmallPostCardState extends State<_SmallPostCard> {
  late int _count;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    _count = widget.post.interested;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(widget.post.emoji,
                      style: const TextStyle(fontSize: 26))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TypeBadge(type: widget.post.type),
                  const SizedBox(height: 4),
                  Text(widget.post.title,
                      style: AppTextStyles.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(widget.post.date, style: AppTextStyles.labelMedium),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                _liked = !_liked;
                _count += _liked ? 1 : -1;
              }),
              child: Column(
                children: [
                  Icon(_liked ? Icons.favorite : Icons.favorite_border,
                      color: _liked ? Colors.red : AppColors.textLight,
                      size: 22),
                  Text('$_count', style: AppTextStyles.labelMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final isEvent = type == 'EVENT';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isEvent ? const Color(0xFFEDE9FE) : const Color(0xFFD1FAE5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isEvent ? 'EVENTO' : 'CURSO',
        style: AppTextStyles.labelMedium.copyWith(
            color: isEvent ? AppColors.primary : AppColors.success,
            fontWeight: FontWeight.w700,
            fontSize: 10),
      ),
    );
  }
}

class _PostItem {
  final String emoji, title, type, date, description;
  final int interested;
  final bool isHero;
  const _PostItem({
    required this.emoji,
    required this.title,
    required this.type,
    required this.date,
    required this.interested,
    required this.isHero,
    required this.description,
  });
}
