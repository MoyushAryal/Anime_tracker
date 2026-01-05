import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../models/anime_data.dart';
import '../widgets/anime_card.dart';
import 'anime_detail_screen.dart';

class TopWatchedScreen extends StatelessWidget {
  const TopWatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    final topWatched = List.from(animeList)
      ..sort((a, b) => b.currentEpisode.compareTo(a.currentEpisode));

    return Scaffold(
      backgroundColor: const Color(0xFF0A0131),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    ' Top Watched',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Most watched by the community this month',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E0B5B),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('Total Watched', '${_totalEpisodesWatched()}'),
                    _buildStat('Avg Progress', '${_averageProgress()}%'),
                    _buildStat('Active Users', '1.2K'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Top Anime List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: topWatched.length,
                itemBuilder: (context, index) {
                  final anime = topWatched[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF1E0B5B),
                      ),
                      child: Row(
                        children: [
                          // Rank Badge
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getRankColor(index + 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Anime Image
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnimeDetailScreen(anime: anime),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                anime.imagePath,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  anime.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${anime.currentEpisode} episodes watched',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                LinearProgressIndicator(
                                  value: anime.totalEpisodes == 0
                                      ? 0
                                      : anime.currentEpisode / anime.totalEpisodes,
                                  backgroundColor: Colors.white10,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _getProgressColor(anime.currentEpisode / anime.totalEpisodes),
                                  ),
                                  minHeight: 4,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ],
                            ),
                          ),

                          // Watch Count
                          Column(
                            children: [
                              const Icon(
                                Icons.visibility,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${(anime.currentEpisode * 1000).toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.purpleAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.orange;
      default:
        return Colors.purpleAccent;
    }
  }

  Color _getProgressColor(double progress) {
    if (progress > 0.7) return Colors.greenAccent;
    if (progress > 0.4) return Colors.orangeAccent;
    return Colors.purpleAccent;
  }

  int _totalEpisodesWatched() {
    return animeList.fold(0, (sum, anime) => sum + anime.currentEpisode);
  }

  double _averageProgress() {
    final total = animeList.fold(0.0, (sum, anime) {
      return sum + (anime.totalEpisodes == 0 ? 0 : anime.currentEpisode / anime.totalEpisodes);
    });
    return ((total / animeList.length) * 100).roundToDouble();
  }
}