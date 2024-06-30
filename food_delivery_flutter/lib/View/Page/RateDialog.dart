import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/Review.dart';

class RateDialog extends StatefulWidget {
  final Review review;
  final Function(int) onRate;

  RateDialog({required this.review, required this.onRate});

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  int rate = 0;

  @override
  void initState() {
    super.initState();
    rate = widget.review.rating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Đánh giá",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: 75,
        child: Column(
          children: [
            Text(
              "Đánh giá của bạn về món ăn $rate",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      rate = 1;
                    });
                  },
                  icon: rate >= 1 ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      rate = 2;
                    });
                  },
                  icon: rate >= 2 ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      rate = 3;
                    });
                  },
                  icon: rate >= 3 ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      rate = 4;
                    });
                  },
                  icon: rate >= 4 ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      rate = 5;
                    });
                  },
                  icon: rate >= 5 ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onRate(rate);
            Navigator.pop(context);
          },
          child: Text("Xác nhận"),
        ),
      ],
    );
  }
}