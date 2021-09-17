import 'package:ecommerce_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCart extends StatelessWidget {

  final String? ProductId;
  final Function? OnPressed;
  final String? imageUrl;
  final String? title;
  final String? price;

  const ProductCart({this.ProductId ,this.OnPressed, this.imageUrl, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Productpage(productId: ProductId,)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        child: Stack(
          children: [
            Container(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "$imageUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        title!,
                        style: GoogleFonts.allertaStencil(fontSize: 18,fontWeight: FontWeight.w600)
                    ),
                    Text(
                      price!,
                      style: TextStyle(
                          fontSize: 18,
                          color:
                          Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
