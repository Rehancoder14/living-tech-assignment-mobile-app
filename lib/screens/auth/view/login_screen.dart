import 'package:flutter/material.dart';
import 'package:livingtechassignment/screens/auth/provider/auth_provider.dart';
import 'package:livingtechassignment/screens/auth/view/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 40),
                child: const Text(
                  "Welcome \nback",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      right: 35,
                      left: 35),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: context
                                .read<AuthProvider>()
                                .loginEmailController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: context
                                .read<AuthProvider>()
                                .loginPassController,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Color(0xff4c505c),
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Consumer<AuthProvider>(
                                  builder: (context, provider, _) {
                                return CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505c),
                                  child: provider.isLoadingLogin
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            context
                                                .read<AuthProvider>()
                                                .login(context: context);
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ),
                                );
                              })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 18,
                                        color: Color(0xff4c505c)),
                                  )),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forget Password',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 18,
                                        color: Color(0xff4c505c)),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(child:
                  Consumer<AuthProvider>(builder: (context, provider, _) {
                return Center(
                  child: provider.isLoadingReg
                      ? const CircularProgressIndicator()
                      : Container(),
                );
              }))
            ],
          )),
    );
  }
}
