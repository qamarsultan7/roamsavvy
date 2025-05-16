import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'infosection.dart'; // Add this import

class AISummarySection extends StatelessWidget {
  final String summary;
  const AISummarySection({
    super.key,
    this.summary =
        "This restaurant is known for its cozy atmosphere, friendly staff, and a diverse menu featuring both classic and modern dishes. Customers often praise the quick service and the quality of the signature burger and deluxe pizza. The house salad is a favorite among health-conscious diners. The location is convenient, and the restaurant maintains high standards of cleanliness. Overall, it's a popular choice for families and groups looking for a pleasant dining experience with reasonable prices and reliable delivery times.",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InfoSection(
      title: 'AI Summary',
      icon: Icons.smart_toy,
      child: ReadMoreText(
        summary,
        trimLines: 3,
        colorClickableText: theme.colorScheme.primary,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show More',
        trimExpandedText: 'Show Less',
        style: theme.textTheme.bodyLarge,
        moreStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        lessStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}