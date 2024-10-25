import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProbabilityTile extends StatefulWidget {
  final String crop;
  final int score;
  ProbabilityTile({
    Key? key,
    required this.crop,
    required this.score,
  }) : super(key: key);
  @override
  _ProbabilityTileState createState() => _ProbabilityTileState();
}

class _ProbabilityTileState extends State<ProbabilityTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.greenAccent.withOpacity(0.5)
                )
              ),
              alignment: Alignment.center,
              child: Text('${widget.crop}',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 15,
                    letterSpacing: 2
                  ),
                ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Colors.greenAccent.withOpacity(0.5)
                  )
              ),
              alignment: Alignment.center,
              child:Text('${widget.score}',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 15,
                      letterSpacing: 2
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
}
