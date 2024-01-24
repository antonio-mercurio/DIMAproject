import 'package:flutter/material.dart';




class SwipeWidget extends StatelessWidget {
  const SwipeWidget({Key? key});

  @override
 @override
  Widget build(BuildContext context) {

    return Scaffold(
     backgroundColor: Colors.black,
            appBar: AppBar(
                backgroundColor: Colors.black,
        title: Text(
          'Affinder',
          style: TextStyle(color : Colors.white),
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.78,
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
                                  'Milano - Stanza Singola',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans',
                                ),
                                ),
                              ),          
                              ),
                              ],
  
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
                                  fontFamily: 'Plus Jakarta Sans',
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
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite_outline, size: MediaQuery.sizeOf(context).height * 0.05),
                color: Colors.white,
                onPressed: () async {
                 
                }),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.2),
            IconButton(
                icon: Icon(Icons.close_outlined, size: MediaQuery.sizeOf(context).height * 0.05),
                color: Colors.white,
                onPressed: () async {
                  
                }),
            const SizedBox(width: 8),
          ],
        ),
    
    ]
    )
    );
  }
}
