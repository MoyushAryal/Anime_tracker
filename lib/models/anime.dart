class Anime {
  final String title;          // Name of the anime
  final String author;         // Creator/author
  final String imagePath;      // Path to the image in assets
  final int totalEpisodes;     // Total number of episodes
  int currentEpisode;          // Current progress (mutable)

  // Constructor
  Anime({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.totalEpisodes,
    this.currentEpisode = 0,   // Default to 0 if not provided
  });
}
