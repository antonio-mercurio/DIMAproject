import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/shared/constants.dart';
import 'package:prva/shared/loading.dart';

class ModelSigniIn {

  late bool confirmPasswordVisibility;
  late bool passwordVisibility;
  void initialSet(){
    confirmPasswordVisibility = false;
    passwordVisibility = false;
  }

}

class SigniInAdjPage extends StatefulWidget {
   final Function toggleView;

  SigniInAdjPage({required this.toggleView});
 
  @override
  State<SigniInAdjPage> createState() => _SigniInAdjPageState();
}

class _SigniInAdjPageState extends State<SigniInAdjPage> {

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
   
    return  loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0.0,
                title: const Text('Affinder',
                 textAlign: TextAlign.start,
                                style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    ),
                actions: <Widget>[
                  TextButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person,
                      color: Colors.white),
                      label: Text('Register',
                      style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                    ),))
                ]),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 32),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Image.asset(
                'assets/imgprova.jpg',
                height: 400,
                width: 400,
              )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        maxWidth: 570,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFFF1F4F8),
                          width: 2,
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Form(
                        key: _scaffoldKey,
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column( 
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sign in with your account',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF101213),
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                               Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 24),
                                child: Text(
                                  'Welcome back! We missed you.',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF57636C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(24),
                                    ),
                                    style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    keyboardType: TextInputType.emailAddress,
                                     validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                                          setState(() => email = val);
                                  }
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    autofillHints: [AutofillHints.password],
                                    obscureText: !_model.passwordVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(24),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => _model.passwordVisibility =
                                              !_model.passwordVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    style:TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child:  ElevatedButton(
                                  onPressed: () async {
                          if (_scaffoldKey.currentState!.validate()) {
                            //print('valid');
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'invalid credentials';
                                loading = false;
                              });
                            }
                          }
                        },
                                    child : Text('Log in',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                    ),),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(230, 52),
                                      backgroundColor:Colors.black,
                                       elevation: 3.0,
                                       side: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    ),
  
                                  ),
                                ),
                                ]
                              ),
                            
                          ),
                    ),),),
                    )
          ]
    )
            ),
          ),
        ),
    );
  }
}