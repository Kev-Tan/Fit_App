import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/utilities/bottom_navigation_bar_height_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/pages/profile/PickImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  final UserProvider userProvider;

  const ProfilePage({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int CanEdit = 0;
  Uint8List? _image;
  String _profileImageUrl = '';

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    String base64Image = base64Encode(img);

    setState(() {
      _image = img;
      _profileImageUrl = base64Image;
    });
  }

  void SaveProfile(String NameOfUser) async {
    String newImageUrl =
        await widget.userProvider.saveData(_image!, NameOfUser);

    setState(() {
      _profileImageUrl = newImageUrl;
    });

    await widget.userProvider.refreshUser();
  }

  void signUserOut() async {
    if (await GoogleSignIn().isSignedIn()) {
      GoogleSignIn().signOut();
    }
    FirebaseAuth.instance.signOut();
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            label,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: const Color.fromARGB(255, 112, 150, 209),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10), // Adjust the spacing here
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = 700.0;

    final bottomBarHeightProvider =
        Provider.of<BottomNavigationBarHeightProvider>(context);
    final bottomBarHeight = bottomBarHeightProvider.height;

    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, UserProvider, child) {
          final user = UserProvider.user;
          final username = user?.username ?? "Not A Member";
          final gender = user?.gender ?? "Undefined Gender";
          final age = user?.age ?? "Undefined Age";
          final weight = user?.weight ?? "Undefined Weight";
          final height = user?.height ?? "Undefined Height";
          final neckCircumference =
              user?.neck ?? "Undefined Neck Circumference";
          final waistCircumference =
              user?.waist ?? "Undefined Waist Circumference";
          final hipCircumference = user?.hips ?? "Undefined Hip Circumference";
          final goals = user?.goal ?? "Undefined Goal";
          final level = user?.level ?? "Undefined Level";
          final frequency = user?.frequency ?? "Undefined Frequency";
          final duration = user?.duration ?? "Undefined Duration";
          final time = user?.time ?? "Undefined Time";
          _profileImageUrl = user?.profileImageUrl ?? '';

          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150 + containerHeight / 2,
                color: Theme.of(context).colorScheme.primary,
              ),
              Positioned(
                top: 140, // Adjusted the top position
                left: 0, // Set left to 0
                right: 0, // Set right to 0
                child: Container(
                  width: double.infinity,
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 100.0,
                      left: 30.0,
                      right: 30.0,
                      bottom: bottomBarHeight + 10.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoField("Name", username),
                          _buildInfoField("Gender", gender),
                          _buildInfoField("Age", age.toString()),
                          _buildInfoField("Weight", "$weight kg"),
                          _buildInfoField("Height", "$height cm"),
                          _buildInfoField(
                              "Neck Circumference", "$neckCircumference cm"),
                          _buildInfoField(
                              "Waist Circumference", "$waistCircumference cm"),
                          _buildInfoField(
                              "Hip Circumference", "$hipCircumference cm"),
                          _buildInfoField("Fitness Goals", goals),
                          _buildInfoField("Fitness Level", level),
                          _buildInfoField("Workout Frequency", frequency),
                          _buildInfoField("Workout Duration", duration),
                          _buildInfoField("Workout Time", time),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                        userProvider: widget.userProvider),
                                  ),
                                );
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                side: BorderSide(
                                    color: Theme.of(context).colorScheme.primary),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 36, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                signUserOut();
                              },
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 42.0),
                    Text(
                      "PROFILE",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 5.0), // Moved the avatar closer to the profile text
                    GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Theme.of(context).colorScheme.background,
                          backgroundImage: _image != null
                              ? MemoryImage(_image!)
                              : _profileImageUrl.isNotEmpty
                                  ? CachedNetworkImageProvider(_profileImageUrl)
                                      as ImageProvider
                                  : NetworkImage(
                                      'https://static-00.iconduck.com/assets.00/user-icon-1024x1024-dtzturco.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
