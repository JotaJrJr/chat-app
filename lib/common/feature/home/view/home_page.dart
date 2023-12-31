import 'package:chat_app/common/services/auth/auth_service.dart';
import 'package:chat_app/common/feature/chat/view/chat_page.dart';
import 'package:chat_app/common/feature/home/viewmodel/home_view_model.dart';
import 'package:chat_app/common/feature/login/view/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      authService: Provider.of<AuthService>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _viewModel.signOut().then((value) {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
            }),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _viewModel.stream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildUserListItem(doc)).toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    if (_viewModel.firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          navigateToPage(
            ChatPage(
              receiverUserEmail: data['email'],
              receiverUserId: data['uid'],
            ),
          );
        },
        // trailing: CircleAvatar(
        //   backgroundColor: Colors.blue,
        //   child: Text(
        //     data['email'][0].toUpperCase(),
        //     style: const TextStyle(color: Colors.white),
        //   ),
        // ),
        trailing: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            "7", // valor estático do que talvez possa ser implementado
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
