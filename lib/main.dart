import 'package:flutter/material.dart';

import 'globals.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stepper_Page(),
    ),
  );
}

class Stepper_Page extends StatefulWidget {
  const Stepper_Page({Key? key}) : super(key: key);

  @override
  State<Stepper_Page> createState() => _Stepper_PageState();
}

class _Stepper_PageState extends State<Stepper_Page> {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController compasscontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController wordcontroller = TextEditingController();


  int initialstep = 0;

  @override
  void initState() {
    super.initState();
    namecontroller.text = "";
    emailcontroller.text = "";
    passcontroller.text = "";
    compasscontroller.text = "";
    usercontroller.text = "";
    wordcontroller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stepper App"),
        backgroundColor: Colors.red,
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.red,
              ),
        ),
        child: Form(
          key: formkey,
          child: Stepper(
            currentStep: initialstep,
            type: StepperType.vertical,
            onStepTapped: (value) {
              setState(() {
                initialstep = value;
              });
            },
            onStepContinue: () {

              setState(() {
                if (initialstep < 2) {
                  ++initialstep;
                }
              });
            },
            onStepCancel: () {

              namecontroller.clear();
              emailcontroller.clear();
              passcontroller.clear();
              compasscontroller.clear();

              Globals.name  = "";
              Globals.email  = "";
              Globals.pass  = "";
              Globals.compass  = "";

              setState(() {
                if (initialstep > 0) {
                  --initialstep;
                }
              });
            },
            controlsBuilder: (context, detaile) {
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          child: Text("CONTINUE"),
                          onPressed: (){
                            if(formkey.currentState!.validate()){
                              formkey.currentState!.save();
                              setState(() {
                                if (initialstep < 0) {
                                  ++initialstep;
                                }
                              });
                            }
                          }),
                    ),
                    SizedBox(width: 7),
                    Expanded(
                      child: OutlinedButton(
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: detaile.onStepCancel),
                    ),
                  ],
                ),
              );
            },
            steps: [
              Step(
                title: const Text("SignUp"),
                content: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namecontroller,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Any Name";
                          }
                          else
                          {
                            return null;
                          }
                        },
                        onSaved: (val){
                          namecontroller.text = Globals.name!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Full Name",
                          focusColor: Colors.cyan,
                        ),
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Any Email";
                          }
                          else
                          {
                            return null;
                          }
                        },
                        onSaved: (val){
                          emailcontroller.text = Globals.email!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: "Email ID",
                        ),
                      ),
                      TextFormField(
                        controller: passcontroller,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Any Password";
                          }
                          else
                          {
                            return null;
                          }
                        },
                        onSaved: (val){
                          passcontroller.text = Globals.pass!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Password",
                        ),
                      ),
                      TextFormField(
                        controller: compasscontroller,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Password Not Match";
                          }
                          else
                          {
                            return null;
                          }
                        },
                        onSaved: (val){
                          compasscontroller.text = Globals.pass!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Confirm Password",
                        ),
                      ),
                    ],
                  ),
                ),
                isActive: (initialstep >= 0) ? true : false,
                state: StepState.indexed,
              ),
              Step(
                title: const Text("Login"),
                content: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usercontroller,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Any User Name";
                          }
                          else
                          {
                            return null;
                          }
                        },
                        onSaved: (val){
                          usercontroller.text = Globals.user!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "User Name",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: wordcontroller,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Password";
                          }
                          else
                          {
                            return null;
                          }
                        },
                        onSaved: (val){
                          wordcontroller.text = Globals.word!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 8,
                      ),
                    ],
                  ),
                ),
                isActive: (initialstep >= 1) ? true : false,
              ),
              Step(
                state: StepState.complete,
                title: const Text("Home"),
                content: TextFormField(),
                isActive: (initialstep >= 2) ? true : false,
                //state: ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
