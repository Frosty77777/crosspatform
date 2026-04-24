import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/search_history_notifier.dart';

class PersistentSearchBar extends ConsumerStatefulWidget {
  final String hintText;
  final ValueChanged<String> onQueryChanged;

  const PersistentSearchBar({
    super.key,
    this.hintText = 'Search cars',
    required this.onQueryChanged,
  });

  @override
  ConsumerState<PersistentSearchBar> createState() => _PersistentSearchBarState();
}

class _PersistentSearchBarState extends ConsumerState<PersistentSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _commitSearch(String value) async {
    final query = value.trim();
    widget.onQueryChanged(query);
    if (query.isEmpty) return;
    await ref.read(searchHistoryProvider.notifier).addSearch(query);
  }

  Future<void> _openHistorySheet() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Consumer(
            builder: (context, ref, _) {
              final historyState = ref.watch(searchHistoryProvider);
              return historyState.when(
                data: (history) {
                  if (history.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: Text('No recent searches')),
                    );
                  }
                  return ListView.separated(
                    itemCount: history.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = history[index];
                      return CustomDropDownMenuItem(
                        title: item,
                        onDelete: () async {
                          await ref.read(searchHistoryProvider.notifier).removeSearch(item);
                        },
                        onTap: () async {
                          _controller.text = item;
                          widget.onQueryChanged(item);
                          await ref
                              .read(searchHistoryProvider.notifier)
                              .addSearch(item);
                          if (context.mounted) Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                error: (error, stackTrace) =>
                    const Center(child: Text('Failed to load history')),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onChanged: widget.onQueryChanged,
            onSubmitted: _commitSearch,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          tooltip: 'Recent searches',
          onPressed: _openHistorySheet,
          icon: const Icon(Icons.history),
        ),
      ],
    );
  }
}

class CustomDropDownMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CustomDropDownMenuItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(title),
      trailing: IconButton(
        icon: const Icon(Icons.close),
        tooltip: 'Delete',
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
