import 'package:flutter/material.dart';
import '../widgets/anime_card.dart';
import '../widgets/search_bar.dart';
import '../models/anime_data.dart';
import '../screens/anime_detail_screen.dart';
import '../models/anime.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Anime> _filteredAnimeList = List.from(animeList);
  bool _isSearching = false;

  void _filterAnime(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredAnimeList = List.from(animeList);
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredAnimeList = animeList
            .where((anime) => anime.title.toLowerCase().contains(lowerQuery))
            .toList();
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _isSearching = false;
      _filteredAnimeList = List.from(animeList);
    });
  }

  // Top picks based on current episode progress
  List<Anime> get _topPicks => List.from(animeList)
    ..sort((a, b) => b.currentEpisode.compareTo(a.currentEpisode))
    ..take(4)
    .toList();

  // Recommendations based on completion percentage
  List<Anime> get _recommendations => List.from(animeList)
    ..shuffle()
    ..take(4)
    .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0131),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            //  App Bar 
            SliverAppBar(
              backgroundColor: const Color(0xFF0A0131),
              elevation: 0,
              pinned: true,
              floating: true,
              title: const Text(
                'Discover',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterAnime,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search anime, genres, or authors...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF1E0B5B),
                        prefixIcon: const Icon(Icons.search, color: Colors.purpleAccent),
                        suffixIcon: _isSearching
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: Colors.white54),
                                onPressed: _clearSearch,
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //  Search Results
            if (_isSearching)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final anime = _filteredAnimeList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: AnimeCard(
                        anime: anime,
                        backgroundColor: const Color(0xFF1E0B5B),
                      ),
                    );
                  },
                  childCount: _filteredAnimeList.length,
                ),
              )
            else
              // Regular Content Sections
              SliverList(
                delegate: SliverChildListDelegate([
                  // 🔹 Top Picks Section
                  _buildSectionHeader(
                    title: '🔥 Top Picks This Week',
                    subtitle: 'Most watched by the community',
                  ),
                  _buildHorizontalAnimeList(_topPicks),

                  const SizedBox(height: 30),

                  //  Recommendations For You
                  _buildSectionHeader(
                    title: '🎯 Recommended For You',
                    subtitle: 'Based on your watching history',
                  ),
                  _buildHorizontalAnimeList(_recommendations),

                  const SizedBox(height: 30),

                  // Continue Watching
                  _buildSectionHeader(
                    title: '▶️ Continue Watching',
                    subtitle: 'Pick up where you left off',
                  ),
                  _buildContinueWatchingSection(),

                  const SizedBox(height: 30),

                  //Trending Now
                  _buildSectionHeader(
                    title: '📈 Trending Now',
                    subtitle: 'What everyone is talking about',
                  ),
                  _buildTrendingSection(),

                  const SizedBox(height: 30),

                  //All Anime (Grid View)
                  _buildSectionHeader(
                    title: '📚 All Anime Collection',
                    subtitle: 'Explore complete library',
                  ),
                  _buildAnimeGrid(),

                  const SizedBox(height: 40),
                ]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalAnimeList(List<Anime> animeList) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          final anime = animeList[index];
          final progress = anime.totalEpisodes == 0
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
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF1E0B5B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Anime Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      anime.imagePath,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          color: Colors.grey.shade800,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.white54,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Progress Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.purpleAccent,
                      ),
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      anime.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Episode Count
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${anime.currentEpisode}/${anime.totalEpisodes}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContinueWatchingSection() {
    final continueWatching = animeList
        .where((anime) => anime.currentEpisode > 0 && anime.currentEpisode < anime.totalEpisodes)
        .toList();

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
        itemCount: continueWatching.length,
        itemBuilder: (context, index) {
          final anime = continueWatching[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetailScreen(anime: anime),
                ),
              );
            },
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF1E0B5B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.asset(
                      anime.imagePath,
                      width: 120,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            anime.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Continue from Episode ${anime.currentEpisode}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purpleAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.purpleAccent),
                            ),
                            child: const Text(
                              'RESUME',
                              style: TextStyle(
                                color: Colors.purpleAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: animeList.map((anime) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF1E0B5B),
              ),
              child: Row(
                children: [
                  // Rank Badge
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${animeList.indexOf(anime) + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Anime Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      anime.imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          anime.author,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Trending Icon
                  const Icon(
                    Icons.trending_up,
                    color: Colors.greenAccent,
                    size: 24,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAnimeGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          final anime = animeList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetailScreen(anime: anime),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF1E0B5B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      anime.imagePath,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Info
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          anime.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.play_circle_outline,
                              color: Colors.purpleAccent,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${anime.currentEpisode}/${anime.totalEpisodes}',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}