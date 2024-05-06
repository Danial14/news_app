import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'home_screen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              child: Card(
                color: Color(0xff6CC9E9),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.98,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: MaterialStateOutlineInputBorder.resolveWith((states){return states.contains(MaterialState.focused) ?
                              OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.purpleAccent, width: 2))
                              :
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.black, width: 2));
                              }),
                              prefixIcon: Icon(
                                Icons.email
                              ),
                              prefixIconColor: MaterialStateColor.resolveWith((states){
                                return states.contains(MaterialState.focused) ? Colors.purpleAccent : Colors.grey;
                              })
                            ),
                            onSaved: (val){
                              _email = val!;
                            },
                            validator: (val){
                              if(val!.isEmpty || !val.contains("@")){
                                return "Invalid email address";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            onSaved: (val){
                              _password = val!;
                            },
                            validator: (val){
                              if(val!.length < 6){
                                return "Invalid password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: MaterialStateOutlineInputBorder.resolveWith((states){return states.contains(MaterialState.focused) ?
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.greenAccent, width: 2))
                                    :
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.black, width: 2));
                                }),
                                prefixIcon: Icon(
                                    Icons.password
                                ),
                                prefixIconColor: MaterialStateColor.resolveWith((states){
                                  return states.contains(MaterialState.focused) ? Colors.greenAccent : Colors.grey;
                                })
                            ),
                          ),
                          SizedBox(height: 15,),
                          ElevatedButton(onPressed: (){
                            _validateUser();
                          }, child: Text("Signup"), style: ElevatedButton.styleFrom(backgroundColor: Colors.red),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _validateUser() async{
    FormState? formState = _formKey.currentState;
    bool isValid = formState!.validate();
    if(isValid){
      formState.save();
      try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email, password: _password);
       if(userCredential.user != null){
         Navigator.of(context).pushReplacement(PageTransition(child: HomeScreen(), type: PageTransitionType.bottomToTop, duration: Duration(seconds: 3)));
       }
      }
      catch(e){

      }
    }
  }
}
