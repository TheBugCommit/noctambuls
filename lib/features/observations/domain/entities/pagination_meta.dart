import 'package:equatable/equatable.dart';

class PaginationMeta extends Equatable {
  const PaginationMeta({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasMore,
    this.serverTime,
  });

  const PaginationMeta.empty()
      : currentPage = 0,
        totalPages = 0,
        totalItems = 0,
        hasMore = false,
        serverTime = null;

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasMore;
  final String? serverTime;

  @override
  List<Object?> get props => [
    currentPage,
    totalPages,
    totalItems,
    hasMore,
    serverTime,
  ];
}
