import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../models/anime_data.dart';
import '../screens/language_screen.dart';
import '../screens/help_support_screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = true;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    final completedAnime = animeList.where((a) => a.currentEpisode >= a.totalEpisodes).length;
    final totalEpisodes = animeList.fold(0, (sum, a) => sum + a.currentEpisode);
    final totalAnime = animeList.length;

    return Scaffold(
      backgroundColor: _darkMode ? const Color(0xFF0A0131) : Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _darkMode ? const Color(0xFF1E0B5B) : Colors.purple[700],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Profile Picture
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purpleAccent.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.purpleAccent,
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // User Info
                    const Text(
                      'Anime Lover',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    Text(
                      '@anime_fan_123',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildProfileStat('Anime', totalAnime.toString()),
                        _buildProfileStat('Episodes', totalEpisodes.toString()),
                        _buildProfileStat('Completed', completedAnime.toString()),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Quick Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📊 Your Stats',
                      style: TextStyle(
                        color: _darkMode ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    _buildStatCard(
                      'Total Watch Time',
                      '${(totalEpisodes * 24).toString()} minutes',
                      Icons.timer,
                      Colors.blueAccent,
                    ),
                    const SizedBox(height: 10),
                    
                    _buildStatCard(
                      'Completion Rate',
                      totalAnime > 0 
                          ? '${((completedAnime / totalAnime) * 100).toStringAsFixed(1)}%'
                          : '0%',
                      Icons.check_circle,
                      Colors.greenAccent,
                    ),
                    const SizedBox(height: 10),
                    
                    _buildStatCard(
                      'Current Streak',
                      '7 days',
                      Icons.local_fire_department,
                      Colors.orangeAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Recent Activity
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📝 Recent Activity',
                      style: TextStyle(
                        color: _darkMode ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    ..._buildRecentActivities(),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Settings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: _darkMode ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    _buildSettingItem(
                      Icons.notifications,
                      'Notifications',
                      _notifications,
                      onToggle: (value) {
                        setState(() {
                          _notifications = value;
                        });
                      },
                    ),
                    _buildSettingItem(
                      Icons.dark_mode,
                      'Dark Mode',
                      _darkMode,
                      onToggle: (value) {
                        setState(() {
                          _darkMode = value;
                        
                        });
                      },
                    ),
                    _buildSettingItem(
                      Icons.language,
                      'Language',
                      false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguageScreen(),
                          ),
                        );
                      },
                    ),
                    _buildSettingItem(
                      Icons.help,
                      'Help & Support',
                      false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpSupportScreen(),
                          ),
                        );
                      },
                    ),
                    _buildSettingItem(
                      Icons.logout,
                      'Logout',
                      false,
                      isLogout: true,
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.purpleAccent,
            fontSize: 20,
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _darkMode ? const Color(0xFF1E0B5B) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: _darkMode ? null : [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _darkMode ? Colors.white70 : Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: _darkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecentActivities() {
    final recentAnime = animeList.take(3).toList();
    
    return recentAnime.map((anime) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _darkMode ? const Color(0xFF1E0B5B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _darkMode ? null : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                anime.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50,
                    height: 50,
                    color: _darkMode ? Colors.grey[800] : Colors.grey[200],
                    child: Icon(
                      Icons.image_not_supported,
                      color: _darkMode ? Colors.white54 : Colors.grey[500],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: TextStyle(
                      color: _darkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Watched episode ${anime.currentEpisode}',
                    style: TextStyle(
                      color: _darkMode ? Colors.white70 : Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '2 hours ago',
                    style: TextStyle(
                      color: _darkMode ? Colors.white54 : Colors.grey[500],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    bool hasToggle, {
    bool isLogout = false,
    Function(bool)? onToggle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isLogout 
              ? Colors.red.withOpacity(0.2)
              : _darkMode ? const Color(0xFF1E0B5B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: !_darkMode && !isLogout ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ] : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout ? Colors.red : (_darkMode ? Colors.white70 : Colors.grey[700]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isLogout ? Colors.red : (_darkMode ? Colors.white : Colors.black),
                  fontSize: 16,
                ),
              ),
            ),
            if (hasToggle && !isLogout)
              Switch(
                value: _darkMode && title == 'Dark Mode' ? _darkMode : 
                       !_darkMode && title == 'Notifications' ? _notifications : true,
                onChanged: onToggle,
                activeColor: Colors.purpleAccent,
              ),
            if (!hasToggle && !isLogout)
              Icon(
                Icons.chevron_right,
                color: _darkMode ? Colors.white54 : Colors.grey[500],
              ),
            if (isLogout)
              const Icon(Icons.chevron_right, color: Colors.red),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _darkMode ? const Color(0xFF1E0B5B) : Colors.white,
          title: Text(
            'Logout',
            style: TextStyle(
              color: _darkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: _darkMode ? Colors.white70 : Colors.grey[700],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: _darkMode ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false, // Remove all routes
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}