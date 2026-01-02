import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../screens/anime_detail_screen.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime; // the anime object
  final Color backgroundColor;

  const AnimeCard({
    super.key,
    required this.anime,
    this.backgroundColor = const Color(0xFF0A0131),
  });

  @override
  Widget build(BuildContext context) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  anime.imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      anime.author,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: anime.currentEpisode / anime.totalEpisodes,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.bookmark_border, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
