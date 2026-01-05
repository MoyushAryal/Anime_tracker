import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: const Color(0xFF3B2A8B),
      ),
      backgroundColor: const Color(0xFF0A0131),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              ' Contact Support',
              'Need help? Our support team is available 24/7.',
              [
                _buildContactItem(
                  Icons.email,
                  'Email Us',
                  'support@animetracker.com',
                  () => _launchEmail(),
                ),
                _buildContactItem(
                  Icons.phone,
                  'Call Us',
                  '+1 (555) 123-4567',
                  () => _launchPhone(),
                ),
                _buildContactItem(
                  Icons.chat,
                  'Live Chat',
                  'Available 9AM - 6PM',
                  () => _showLiveChat(context),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildSection(
              ' Frequently Asked Questions',
              'Find quick answers to common questions.',
              [
                _buildFAQItem(
                  'How do I reset my password?',
                  'Go to Login screen → Forgot Password → Enter your email.',
                ),
                _buildFAQItem(
                  'Can I download episodes for offline viewing?',
                  'Yes! Tap the download icon on any episode.',
                ),
                _buildFAQItem(
                  'How do I change my profile picture?',
                  'Profile → Edit Profile → Upload new picture.',
                ),
                _buildFAQItem(
                  'Why is an episode not playing?',
                  'Check your internet connection or try clearing app cache.',
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildSection(
              ' Tutorials & Guides',
              'Learn how to use all features of AnimeTracker.',
              [
                _buildGuideItem(
                  'Getting Started Guide',
                  Icons.play_circle_fill,
                  Colors.purpleAccent,
                ),
                _buildGuideItem(
                  'How to Track Your Progress',
                  Icons.track_changes,
                  Colors.blueAccent,
                ),
                _buildGuideItem(
                  'Creating Custom Lists',
                  Icons.playlist_add,
                  Colors.greenAccent,
                ),
                _buildGuideItem(
                  'Notification Settings',
                  Icons.notifications,
                  Colors.orangeAccent,
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildSection(
              'Legal',
              'Important information about our service.',
              [
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.white70),
                  title: const Text(
                    'Terms of Service',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                  onTap: () => _showTerms(context),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.white70),
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                  onTap: () => _showPrivacyPolicy(context),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Version 1.0.0 • © 2024 AnimeTracker',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String subtitle, List<Widget> children) {
    return Column(
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
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      color: const Color(0xFF12084F),
      child: ListTile(
        leading: Icon(icon, color: Colors.purpleAccent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      color: const Color(0xFF12084F),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(color: Colors.white),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideItem(String title, IconData icon, Color color) {
    return Card(
      color: const Color(0xFF12084F),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
        onTap: () {},
      ),
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@animetracker.com',
      queryParameters: {'subject': 'AnimeTracker Support'},
    );
    
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: '+15551234567');
    
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    }
  }

  void _showLiveChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E0B5B),
        title: const Text(
          'Live Chat',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Our live chat support hours are 9AM - 6PM (GMT).\n\nClick below to start a chat session.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
             
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
            ),
            child: const Text('Start Chat'),
          ),
        ],
      ),
    );
  }

  void _showTerms(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LegalScreen(
          title: 'Terms of Service',
          content: 'Legal terms content here...',
        ),
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LegalScreen(
          title: 'Privacy Policy',
          content: 'Privacy policy content here...',
        ),
      ),
    );
  }
}

class LegalScreen extends StatelessWidget {
  final String title;
  final String content;
  
  const LegalScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF3B2A8B),
      ),
      backgroundColor: const Color(0xFF0A0131),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(color: Colors.white70, height: 1.5),
        ),
      ),
    );
  }
}