import 'package:flutter/material.dart';

import 'infosection.dart';
// ...existing imports...

class MainFeaturesSection extends StatefulWidget {
  final List<String> features;
  final int initialVisibleCount;

  const MainFeaturesSection({
    super.key,
    required this.features,
    this.initialVisibleCount = 4,
  });

  @override
  State<MainFeaturesSection> createState() => _MainFeaturesSectionState();
}

class _MainFeaturesSectionState extends State<MainFeaturesSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleCount = widget.initialVisibleCount;
    final showSeeMore = widget.features.length > visibleCount;
    final featuresToShow =
        _expanded || !showSeeMore
            ? widget.features
            : widget.features.take(visibleCount).toList();

    return InfoSection(
      title: 'Main Features',
      icon: Icons.local_offer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                featuresToShow
                    .map(
                      (feature) => Chip(
                        label: Text(
                          feature,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        backgroundColor: theme.colorScheme.primary.withAlpha(
                          180,
                        ),
                        shape: StadiumBorder(
                          side: BorderSide(
                            color:
                                theme
                                    .colorScheme
                                    .onSurface, // Add primary color border
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          if (showSeeMore)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                child: Text(
                  _expanded ? 'See Less' : 'See More',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
