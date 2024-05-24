import 'package:flutter/material.dart';
import 'package:livingtechassignment/screens/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35, top: 40),
                    child: const Text(
                      "Account\nCreate",
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.28,
                          right: 35,
                          left: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: context
                                .read<AuthProvider>()
                                .regUserNameController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.white10))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller:
                                context.read<AuthProvider>().regEmailController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Consumer<AuthProvider>(
                              builder: (context, provider, _) {
                            return TextField(
                              controller: provider.regPassController,
                              obscureText: provider.isObscureReg,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      provider.isObscureReg
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      provider.isObscureReg =
                                          !provider.isObscureReg;
                                    },
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            );
                          }),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Color(0xff4c505c),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505c),
                                child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<AuthProvider>()
                                          .register(context: context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
        Positioned(
            child: Consumer<AuthProvider>(builder: (context, provider, _) {
          return Center(
            child: provider.isLoadingReg
                ? const CircularProgressIndicator()
                : Container(),
          );
        }))
      ],
    );
  }
}
