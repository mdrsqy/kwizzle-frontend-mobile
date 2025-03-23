import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.notifications, color: Colors.purple),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.purple),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Play quiz together with your friends now!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            // Find Friends Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Find Friends',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(height: 32),
            // Discover Section
            Text(
              'Discover',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            // Discover Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDiscoverCard(
                    title: 'Get Smarter with Productivity Quizzes...',
                    author: 'Titus Kitamura',
                    quizCount: 16,
                  ),
                  SizedBox(width: 16),
                  _buildDiscoverCard(
                    title: 'Great Ideas Come from Brilliant Minds...',
                    author: 'Alfonzo Schuessler',
                    quizCount: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            // Top Authors Section
            Text(
              'Top Authors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            // Top Authors Profile Circle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAuthorAvatar('Rayford'),
                _buildAuthorAvatar('Willard'),
                _buildAuthorAvatar('Hannah'),
                _buildAuthorAvatar('Geoffrey'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method for building discover cards
  Widget _buildDiscoverCard({
    required String title,
    required String author,
    required int quizCount,
  }) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Text('By $author', style: TextStyle(color: Colors.purple)),
          Spacer(),
          Text('$quizCount Qs', style: TextStyle(color: Colors.purple)),
        ],
      ),
    );
  }

  // Reusable method for building author avatars
  Widget _buildAuthorAvatar(String name) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.purple,
      child: Text(
        name[0],
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
