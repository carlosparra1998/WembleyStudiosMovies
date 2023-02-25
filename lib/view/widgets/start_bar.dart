import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StarBar extends StatelessWidget {
  double voteAverage;
  int voteCount;
  List<Widget> emptyStarsArray = [];

  StarBar(this.voteAverage, this.voteCount, {super.key});

  IconData getStar(int pos) {
    return (voteAverage < 2 * pos - 1) ? Icons.star_border : ((voteAverage >= 2 * pos) ? Icons.star : Icons.star_half);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        voteAverage.toString() + " ",
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      Icon(
        getStar(1),
        size: 14.0,
      ),
      Icon(
        getStar(2),
        size: 14.0,
      ),
      Icon(
        getStar(3),
        size: 14.0,
      ),
      Icon(
        getStar(4),
        size: 14.0,
      ),
      Icon(
        getStar(5),
        size: 14.0,
      ),
      Text(" (" + voteCount.toString() + ")")
    ]);
  }
}
