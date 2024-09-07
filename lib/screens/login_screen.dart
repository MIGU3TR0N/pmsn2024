import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final gifLoading = Positioned(
  child: Image.asset('assets/load.gif', height: 100,)
);

class _LoginScreenState extends State<LoginScreen> {

  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
      ),
    );
    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.password),
      ),
    );
    final btnLogin = Positioned(
      bottom: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
        ),
        onPressed: (){
          isLoading = true;
          setState(() {});
          Future.delayed(
            const Duration(milliseconds: 4000)
          ).then((value) => {
            isLoading = false,
            setState(() { }),
            Navigator.pushNamed(context, "/home")
          });
        }, 
        child: const Text('Validar Usuario')
      ),
    );

    final ctnCredentials = Positioned(
      bottom: 90,
      child: Container(
        width: MediaQuery.of(context).size.width*.9,
        decoration: BoxDecoration(
          color: const Color.fromARGB(146, 255, 255, 255),
          borderRadius: BorderRadius.circular(10)
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            txtUser,
            txtPwd,
          ],
        ),
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.deepOrange,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/cs.png'),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Image.asset('assets/cs2-logo.png', width: 360,)
            ),
            ctnCredentials,
            btnLogin,
            isLoading ? gifLoading : Container(),
          ],
        ),
      ),
    );
  }
}
