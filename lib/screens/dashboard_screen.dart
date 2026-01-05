
import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'top_watched_screen.dart';    
import 'profile_screen.dart';      
import '../widgets/anime_card.dart';
import '../models/anime_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  
  // Use  imported screen widgets
  final List<Widget> _pages = [
    const MyListScreen(),     
    const SearchScreen(),      
    const TopWatchedScreen(),  
    const ProfileScreen(),     
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF0A0131),
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'My List'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Top Watched'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A0131), Color(0xFF0D0A4C), Color(0xFF05073F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'My Animes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  final anime = animeList[index];
                  return AnimeCard(
                    anime: anime,
                    backgroundColor: const Color(0xFF12084F),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

