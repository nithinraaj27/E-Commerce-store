import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {

  final List ImageList;

  const ImageSwipe({required this.ImageList});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num){
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for(var i =0; i < widget.ImageList.length; i++)
                Container(
                  child: Image.network('${widget.ImageList[i]}',fit: BoxFit.fitHeight,),
                )
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i=0; i<widget.ImageList.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    width: _selectedPage == i ? 25 : 12,
                      height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)
                    ),
                  ),
              ],
            )
          )
        ],
      ),);
  }
}
