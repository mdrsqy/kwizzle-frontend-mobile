import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'create_page.dart';
import 'library_page.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;

  // Function to handle item tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserHomePage()),
      );
    } else if (index == 1) {
      // Library tab
      // Navigate to Library page (if needed)
    } else if (index == 2) {
      // Join tab
      // Navigate to Join page (if needed)
    } else if (index == 3) {
      // Create tab
      // Navigate to Create page (if needed)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Text(
                "Kwizzle",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFF6C63FF)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFF6C63FF)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Play quiz with your friends now!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6C63FF),
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
            Text(
              'Discover Quizzes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
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
            Text(
              'Top Authors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Handles the tap on each item
        selectedItemColor: Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.group_add), label: 'Join'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

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
              color: Color(0xFF6C63FF),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Text('By $author', style: TextStyle(color: Color(0xFF6C63FF))),
          Spacer(),
          Text('$quizCount Qs', style: TextStyle(color: Color(0xFF6C63FF))),
        ],
      ),
    );
  }

  Widget _buildAuthorAvatar(String name) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Color(0xFF6C63FF),
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
