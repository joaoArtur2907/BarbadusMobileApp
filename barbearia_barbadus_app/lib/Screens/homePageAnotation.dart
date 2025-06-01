// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
//
// class homePageAnotation extends StatefulWidget {
//   const homePageAnotation({super.key});
//   @override
//   State<homePageAnotation> createState() => _HomePageAnotationState();
// }
//
// class _HomePageState extends State<homePageAnotation> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             // campo de email
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextFormField(
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Nome'),
//               ),
//             ),
//             // campo da matricula
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15.0, top: 15.0, bottom: 0),
//               child: TextFormField(
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 keyboardType: TextInputType.number,
//                 // controller: matriculaController,
//                 textAlign: TextAlign.center,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Matrícula'),
//               ),
//             ),
//             // campo do email
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15.0, top: 15.0, bottom: 0),
//               child: TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 // controller: matriculaController,
//                 textAlign: TextAlign.center,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'E-mail'),
//               ),
//             ),
//             Container(
//               height: 100,
//               width: 72,
//               decoration: BoxDecoration(
//                   color: Colors.white70,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(width: 2, color: Colors.blue)
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 // child: Image.network(
//                 //   imageController.text,
//                 //   fit: BoxFit.cover,
//                 // ),
//               ),
//             ),
//             // campo de senha
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15.0, top: 15.0, bottom: 0),
//               child: TextFormField(
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password'),
//               ),
//             ),
//
//             // botao de login
//             Container(
//               height: 50,
//               width: 250,
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(20)),
//               child: TextButton(
//                 onPressed: (){
//                   print('screen apos logado');
//                 },
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 90,
//             ),
//             // criar sua conta
//             TextButton(onPressed: (){},
//               child: const Text("Crie sua conta", style: TextStyle(color: Colors.blue),),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
