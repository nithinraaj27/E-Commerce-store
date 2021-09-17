import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List prodictsize;
  final Function(String)? onselected;
  const ProductSize({Key? key, required this.prodictsize, this.onselected}) : super(key: key);
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (var i = 0; i < widget.prodictsize.length; i++)
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: (){
              widget.onselected!("${widget.prodictsize[i]}");
              setState(() {
                _selectedIndex = i;
              });
            },
            child: Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                  color: _selectedIndex == i ? Colors.red : Colors.grey),
              alignment: Alignment.center,
              child: Text(
                "${widget.prodictsize[i]}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == i ? Colors.white : Colors.black,
                    fontSize: 16),
              ),
            ),
          ),
        )
    ]);
  }
}
