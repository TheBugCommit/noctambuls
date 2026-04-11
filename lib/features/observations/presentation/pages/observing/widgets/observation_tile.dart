import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';

class ObservationTile extends StatelessWidget {
  const ObservationTile({
    required this.record,
    super.key,
  });

  final ObservationRecord record;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.xs,
        ),
        leading: const Icon(Icons.pets_outlined),
        title: Text(record.speciesId),
        subtitle: Text(record.contactType),
      ),
    );
  }
}
