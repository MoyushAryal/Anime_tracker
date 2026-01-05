import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../screens/anime_detail_screen.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final Color backgroundColor;

  const AnimeCard({
    super.key,
    required this.anime,
    this.backgroundColor = const Color(0xFF0A0131),
  });

  @override
  Widget build(BuildContext context) {
    // divide by zero bata prevent
    final double progress = anime.totalEpisodes == 0
        ? 0.0
        : anime.currentEpisode / anime.totalEpisodes;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailScreen(anime: anime),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // IMAGE 
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  anime.imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey.shade800,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              // TEXT PROGRESS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      anime.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.purpleAccent,
                      ),
                      minHeight: 6,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${anime.currentEpisode}/${anime.totalEpisodes} episodes',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.bookmark_border,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
