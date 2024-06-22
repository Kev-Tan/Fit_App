import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/utilities/bottom_navigation_bar_height_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/pages/profile/PickImage.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    //print(base64Image);

    setState(() {
      _image = img;
      _profileImageUrl = base64Image;
    });
    
  }

  void SaveProfile(String NameOfUser) async{
    String newImageUrl = await widget.userProvider.saveData(_image!, NameOfUser);
    
    // Refresh user data in the provider to ensure the profile page displays the latest information
    //await widget.userProvider.refreshUser();

    setState(() {
      //print(newImageUrl);
      _profileImageUrl = newImageUrl;
    });

  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: const Color.fromARGB(255, 112, 150, 209),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 3.5),
          child: Container(
            height: 40,
            width: 334,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 249, 240),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                //color: Colors.black,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(1, 5), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 12,
              ),
              child: Text(
                value,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = 90.0; // Width of the green container
    double containerHeight = 180.0; // Height of the green container

    final bottomBarHeightProvider =
        Provider.of<BottomNavigationBarHeightProvider>(context);
    final bottomBarHeight = bottomBarHeightProvider.height;

    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, UserProvider, child) {
          final user = UserProvider.user;
          final username = user?.username ?? "Not A Member";
          //final gender = user?.gender ?? "Undefined Gender (Attack Helicopter)";
          final age = user?.age ?? "Undefined Age";
          final weight = user?.weight ?? "Undefined Weight";
          final height = user?.height ?? "Undefined Height";
          final neckCircumference = user?.neck ?? "Undefined Neck Circumference";
          _profileImageUrl = user?.profileImageUrl ?? ''; 
          //final profileImageUrl = user?.profileImageUrl ?? 'https://static-00.iconduck.com/assets.00/user-icon-1024x1024-dtzturco.png';

          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150 + containerHeight / 2,
                color: Color.fromRGBO(8, 31, 92, 1),
              ),
              Positioned(
                top: 150,
                left: (MediaQuery.of(context).size.width - (containerWidth * 4)) / 2, // Center horizontally
                //left: MediaQuery.of(context).size.width / 8,
                child: Container(
                  width: containerWidth * 4, // Adjusted width for centering
                  height: 700,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 249, 240),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 80), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 100.0,
                      left: 8.0,
                      right: 8.0,
                      bottom: bottomBarHeight + 10.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoField("Name", username),
                          _buildInfoField("Gender", "Attack Helicopter"),
                          _buildInfoField("Age", age.toString()),
                          _buildInfoField("Weight", "$weight kg"),
                          _buildInfoField("Height", "$height cm"),
                          _buildInfoField("Neck Circumference", "$neckCircumference cm"),
                          _buildInfoField("Hip Circumference", "90 cm"),
                          _buildInfoField("Fitness Goals", "Lose Weight"),
                          _buildInfoField("Fitness Level", "Beginner"),
                          _buildInfoField("Workout Frequency", "3-4 times / week"),
                          _buildInfoField("Workout Duration", "30 minutes / workout"),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                //the edit profile LOGIC HERE
                                CanEdit = 1;
                              },
                              child: Text(
                                "Edit Profile",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
          
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                signUserOut();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red, // Change the button color to red
                              ),
                              child: Text(
                                "Logout",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Center(child: 
                            ElevatedButton(
                              onPressed: () {
                                String SomewhatThing = username;
                                SaveProfile(SomewhatThing);
                              }, 
                              child: Text('Save Profile')
                            )
                          ),
                          
                          const SizedBox(height: 20),
                                            
                          const SizedBox(height: 110),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              

              Positioned(
                left: (MediaQuery.of(context).size.width - 180) / 2,
                top: 150 + (containerHeight / 2) - 180,
                child: GestureDetector(
                  onTap: /*Do something here*/selectImage, //_pickImageFromGallery,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color black
                      shape: BoxShape.circle,
                      border: Border.all(
                        //color: Colors.black,
                        width: 2.0,
                      ),
                    ),

                    child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                         backgroundImage: _image != null
                          ? MemoryImage(_image!) // Display the selected image
                          : _profileImageUrl.isNotEmpty
                              ? CachedNetworkImageProvider(_profileImageUrl) as ImageProvider
                              : NetworkImage('https://static-00.iconduck.com/assets.00/user-icon-1024x1024-dtzturco.png'),
                    ),
                    
                  ),
                ),
              ),
          
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "PROFILE",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Color.fromRGBO(255, 255, 255, 0.612),
                      ),
                      //presetFontSizes: [40, 20, 14],
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
      // bottomNavigationBar: MyBottomNavigationBar(
      //   activeIndex: 3,
      // ),
    );
  }

}
