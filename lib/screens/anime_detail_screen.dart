import 'package:flutter/material.dart';
import '../models/anime.dart';


class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0131),
      appBar: AppBar(
        title: Text(anime.title),
        backgroundColor: const Color(0xFF3B2A8B),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // vod 
          Container(
            height: 220,
            width: double.infinity,
            color: Colors.black,
            child: const Center(
              child: Text(
                'Promo Video',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 16),

        //title and all that
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anime.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        anime.author,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Anime Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    anime.imagePath,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 🔹 Scrollable Episode Numbers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  anime.totalEpisodes > 100 ? 100 : anime.totalEpisodes, // show first 100 episodes
                  (index) {
                    final episode = index + 1;
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B2A8B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        episode.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          //brief intro
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Synopsis\n\n'
              'A young pirate named Monkey D. Luffy sets sail on a journey '
              'to find the legendary treasure known as One Piece and become '
              'the King of the Pirates.',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ep list
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Episode List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ep list scrollabble
          SizedBox(
            height: 500, 
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: anime.totalEpisodes > 100 ? 100 : anime.totalEpisodes,
              itemBuilder: (context, index) {
                final bool isFiller = index % 5 == 0; 
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12084F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Ep ${index + 1}',
                          style: TextStyle(
                            color: isFiller ? Colors.redAccent : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Episode title goes here',
                            style: TextStyle(
                              color: isFiller ? Colors.redAccent : Colors.white70,
                            ),
                          ),
                        ),
                        if (isFiller)
                          const Text(
                            'FILLER',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
