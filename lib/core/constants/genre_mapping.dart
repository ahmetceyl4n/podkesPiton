const genreMap = {
  68: 'Tech',
  93: 'Life',
  133: 'Comedy',
  88: 'Business',
  122: 'News',
  82: 'Education',
  134: 'Music',
  100: 'Health',
  99: 'Sports',
  107: 'Religion',
  111: 'True Crime',
  140: 'Kids',
  127: 'History',
};

String mapGenreToCategory(List<int> genreIds) {
  if (genreIds.isEmpty) return 'Unknown';

  for (final id in genreIds) {
    if (genreMap.containsKey(id)) {
      return genreMap[id]!;
    }
  }

  return 'Other';
}


final List<String> availableCategories = [
  'All',
  ...{...genreMap.values},
];
