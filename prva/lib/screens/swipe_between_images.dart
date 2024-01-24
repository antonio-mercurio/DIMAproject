import 'package:flutter/material.dart';

class SwipeWidget extends StatelessWidget {
  const SwipeWidget({Key? key});

  @override
 @override
  Widget build(BuildContext context) {

    return Scaffold(
     backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.green[400],
        title: Text(
          'Details',
        ),
      ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network(
                           'https://i.pinimg.com/originals/d7/75/ba/d775ba84bdb529203308b9d65c1db59f.jpg'
                           ).image,
            ),
          ),
             child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Milano - Stanza Singola',
                        style: TextStyle(color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(134, 9, 9, 9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                                child: Text(
                                  '500',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                                ),
                              ),
                            ),
                          ],
                        )
                        ),
                    ],
                  ),
                ),
              ),
        )
    );
  }
}
