import 'package:flutter/material.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/screens/shared/loading.dart';

class ModelSigniIn {
  late bool confirmPasswordVisibility;
  late bool passwordVisibility;
  void initialSet() {
    confirmPasswordVisibility = false;
    passwordVisibility = false;
  }
}

class SigniInPage extends StatefulWidget {
  final Function toggleView;

  const SigniInPage({super.key, required this.toggleView});

  @override
  State<SigniInPage> createState() => _SigniInPageState();
}

class _SigniInPageState extends State<SigniInPage> {
  ModelSigniIn createModelSigniIn(BuildContext context) {
    return ModelSigniIn();
  }

  late ModelSigniIn _model;
  final AuthService _auth = AuthService();
  final _scaffoldKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    _model = createModelSigniIn(context);
    _model.initialSet();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
                backgroundColor: mainColor,
                elevation: 0.0,
                actions: <Widget>[
                  TextButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(
                        Icons.person,
                        color: backgroundColor,
                        size: MediaQuery.sizeOf(context).width < widthSize
                            ? MediaQuery.sizeOf(context).height * 0.03
                            : MediaQuery.sizeOf(context).height * 0.032,
                      ),
                      label: Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: backgroundColor,
                          fontSize: size16(context),
                        ),
                      ))
                ]),
            body: SafeArea(
              top: true,
              child: Align(
                alignment: const AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 32),
                        child: Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: const AlignmentDirectional(0, 0),
                            child: Image.asset(
                              'assets/logo_affinder_tagliato.jpg',
                              height: MediaQuery.sizeOf(context).height * 0.4,
                              width: MediaQuery.sizeOf(context).height * 0.4,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 700,
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFF1F4F8),
                              width: 2,
                            ),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Form(
                              key: _scaffoldKey,
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sign in with your account',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: const Color(0xFF101213),
                                          fontSize: size32(context),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 24),
                                        child: Text(
                                          'Welcome back! We missed you.',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: const Color(0xFF57636C),
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 16),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Email',
                                                labelStyle: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color:
                                                      const Color(0xFF57636C),
                                                  fontSize: size16(context),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: mainColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: errorColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: errorColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                filled: true,
                                                fillColor: backgroundColor,
                                                contentPadding:
                                                    const EdgeInsets.all(24),
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: const Color(0xFF101213),
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (val) => val!.isEmpty
                                                  ? 'Enter an email'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() => email = val);
                                              }),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 16),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                              autofillHints: const [
                                                AutofillHints.password
                                              ],
                                              obscureText:
                                                  !_model.passwordVisibility,
                                              decoration: InputDecoration(
                                                labelText: 'Password',
                                                labelStyle: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color:
                                                      const Color(0xFF57636C),
                                                  fontSize: size16(context),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: mainColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: errorColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: errorColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                filled: true,
                                                fillColor: backgroundColor,
                                                contentPadding:
                                                    const EdgeInsets.all(24),
                                                suffixIcon: InkWell(
                                                  onTap: () => setState(
                                                    () => _model
                                                            .passwordVisibility =
                                                        !_model
                                                            .passwordVisibility,
                                                  ),
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
                                                  child: Icon(
                                                    _model.passwordVisibility
                                                        ? Icons
                                                            .visibility_outlined
                                                        : Icons
                                                            .visibility_off_outlined,
                                                    color:
                                                        const Color(0xFF57636C),
                                                    size: size24(context),
                                                  ),
                                                ),
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: const Color(0xFF101213),
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              validator: (val) => val!.length <
                                                      6
                                                  ? 'Enter a password 6+ chars long'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() => password = val);
                                              }),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_scaffoldKey.currentState!
                                                  .validate()) {
                                                setState(() => loading = true);
                                                dynamic result = await _auth
                                                    .signInWithEmailAndPassword(
                                                        email, password);
                                                if (result == null) {
                                                  setState(() {
                                                    error =
                                                        'Invalid credentials';
                                                    loading = false;
                                                  });
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(230, 52),
                                              backgroundColor: mainColor,
                                              elevation: 3.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              side: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              'Log in',
                                              style: TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: backgroundColor,
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child:   
                                Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                   textAlign: TextAlign.center, 
                                    error, 
                                    style: TextStyle(color: errorColor, fontSize: size14(context), fontWeight: FontWeight.bold),
                                  ),),),)
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      )
                    ])),
              ),
            ),
          );
  }
}
