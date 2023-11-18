import 'package:flutter/material.dart';

class ReviewInputScreen extends StatefulWidget {
  const ReviewInputScreen({Key? key}) : super(key: key);

  @override
  _ReviewInputScreenState createState() => _ReviewInputScreenState();
}

class _ReviewInputScreenState extends State<ReviewInputScreen> {
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(219, 22, 110, 1),
        title: const Text('Reviews'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stars:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = index + 1.0;
                        });
                      },
                      child: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        size: 40,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your comments:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _reviewController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        'Write your comments about the dish in the box...',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(219, 22, 110, 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20)),
                  onPressed: () {
                    // Xử lý logic khi nút gửi được nhấn
                  },
                  child: const Text('Submit your review '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
