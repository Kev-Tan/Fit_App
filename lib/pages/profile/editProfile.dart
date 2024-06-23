import 'package:flutter/material.dart';
import 'package:fit_app/models/user_provider.dart';

class EditProfile extends StatefulWidget {
  final UserProvider userProvider;

  const EditProfile({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'New Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Create a modified UserModel to update
                    UserModel updatedUser = UserModel(
                      uid: widget.userProvider.user!.uid,
                      username: _usernameController.text.trim(),
                      profileImageUrl:
                          widget.userProvider.user!.profileImageUrl,
                      email: widget.userProvider.user!.email,
                      gender: widget.userProvider.user!.gender,
                      age: widget.userProvider.user!.age,
                      height: widget.userProvider.user!.height,
                      weight: widget.userProvider.user!.weight,
                      neck: widget.userProvider.user!.neck,
                      waist: widget.userProvider.user!.waist,
                      hips: widget.userProvider.user!.hips,
                      goal: widget.userProvider.user!.goal,
                      level: widget.userProvider.user!.level,
                      frequency: widget.userProvider.user!.frequency,
                      duration: widget.userProvider.user!.duration,
                      time: widget.userProvider.user!.time,
                    );

                    // Call updateUser method of the existing userProvider instance
                    await widget.userProvider.updateUser(updatedUser);

                    // Optionally, clear the text field after update
                    _usernameController.clear();
                  },
                  child: Text('Update User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
