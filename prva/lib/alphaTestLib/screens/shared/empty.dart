import 'package:flutter/material.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';

class EmptyProfile extends StatelessWidget {
  final IconData shapeOfIcon;
  final String textToShow;
  const EmptyProfile(
      {super.key, required this.shapeOfIcon, required this.textToShow});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Align(
            alignment: const AlignmentDirectional(0, -1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  maxWidth: 770,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, 1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: backgroundColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, -1),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 121, 107, 255),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: backgroundColor,
                                width: 4,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: backgroundColor,
                                    width: 4,
                                  ),
                                ),
                                child: Icon(
                                  key: Key('iconCheck'),
                                  shapeOfIcon,
                                  color: backgroundColor,
                                  size: 64,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          key: Key('displayText'),
                          textToShow,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF101213),
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
