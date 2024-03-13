import 'package:flutter/material.dart';


class EmptyProfile extends StatelessWidget{
  const EmptyProfile({super.key});

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
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x33000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFF1F4F8),
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
                                      color:
                                         const Color(0xFFF1F4F8),
                                      width: 4,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4B39EF),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFF1F4F8),
                                          width: 4,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        color:
                                            Colors.white,
                                        size: 64,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30,),
                            const Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'You have already seen all profiles!',
                                textAlign: TextAlign.center,
                               style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF101213),
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),),
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
