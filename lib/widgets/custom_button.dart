import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final bool? ontlinebtn;
  final bool? isLoading;

  const custombutton({this.text, this.onPressed, this.ontlinebtn, this.isLoading});
  @override
  Widget build(BuildContext context) {

    bool _outlinebtn = ontlinebtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed as Function(),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlinebtn? Colors.transparent : Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2,color: Colors.black),
        ),
        margin: EdgeInsets.symmetric(horizontal:24,vertical: 8),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text( text?? "text",style: TextStyle(
                  fontSize: 16,
                  color: _outlinebtn ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator()),
              ),
            )
          ],
        ),
      ),
    );
  }
}

