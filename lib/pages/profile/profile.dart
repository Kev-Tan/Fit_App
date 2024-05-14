import 'package:auto_size_text/auto_size_text.dart';
import 'package:fit_app/utilities/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 40,
          width: 334,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 0, 0),
            borderRadius: BorderRadius.circular(20.0),
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
                color: Colors.white,
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

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150 + containerHeight/2,
            color: Color.fromRGBO(112, 150, 209, 1),
          ),
          Positioned(
            top: 150,
            left: (MediaQuery.of(context).size.width - (containerWidth * 4)) / 2, // Center horizontally
            //left: MediaQuery.of(context).size.width / 8,
            child: Container(
              width: containerWidth * 4, // Adjusted width for centering
              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100.0,
                  left: 8.0,
                  right: 8.0,
                  //bottom: 10.0,
                  ),
                child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoField("Name", "Today"),
                          _buildInfoField("Gender", "Attack Helicopter"),
                          _buildInfoField("Age", "It's just a number"),
                          _buildInfoField("Weight", "80 kg"),
                          _buildInfoField("Height", "180 cm"),
                          _buildInfoField("Neck Circumference", "85 cm"),
                          _buildInfoField("Hip Circumference", "90 cm"),
                          _buildInfoField("Fitness Goals", "Lose Weight"),
                          _buildInfoField("Fitness Level", "Beginner"),
                          _buildInfoField("Workout Frequency", "3-4 times / week"),
                          _buildInfoField("Workout Duration", "30 minutes / workout"),

                          const SizedBox(height: 10),

                          Center(
                            child: ElevatedButton(
                              onPressed: (){
                            
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

                          const SizedBox(height: 110),

                          // Text(
                          //   "Name",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("Today",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                          // const SizedBox(height: 5),
                          // Text(
                          //   "Gender",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("Attack Helicopter",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),
                          
                          // const SizedBox(height: 5),
                          // Text(
                          //   "Age",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("It's just a number",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                          // const SizedBox(height: 5),
                          // Text(
                          //   "Weight",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("80 kg",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                          // const SizedBox(height: 5),
                          // Text(
                          //   "Height",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("180 cm",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                          // const SizedBox(height: 5),
                          // Text(
                          //   "Neck Circumference",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("85 cm",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                          // const SizedBox(height: 5),
                          // Text(
                          //   "Hip Circumference",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("90 cm",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                          // const SizedBox(height: 5),
                          // Text(
                          //   "Fitness Goals",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("Lose Weight",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                          // const SizedBox(height: 5),
                          // Text(
                          //   "Fitness Level",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("Beginner",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),
                          
                          // const SizedBox(height: 5),
                          // Text(
                          //   "Workout Frequency",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("3-4 times / week",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),
                          
                          // const SizedBox(height: 5),
                          // Text(
                          //   "Workout Duration",
                          //   //textWidthBasis: TextWidthBasis.longestLine,
                          //   style: GoogleFonts.lato(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 24,
                          //      color: const Color.fromARGB(255, 0, 0, 0)
                          //   )
                          // ),
                          // const SizedBox(height: 5),
                          // Container(
                          //   height: 40,
                          //   width: 334,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 255, 0, 0),
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //       top: 1,
                          //       bottom: 1,
                          //       right: 12,
                          //       left: 12,
                          //       ),
                          //     child: Text("30 minutes / workout",
                          //       style: GoogleFonts.lato(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 24,
                          //           color: Colors.white
                          //         )
                          //     ),
                          //   ),
                          // ),

                        ],
                      ),
                  ),
              ),
            ),
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width - 180) / 2,
            top: 150 + (containerHeight/2) - 180,
            child: Flexible(
              flex: 5,
              child: Container(
                //margin: EdgeInsets.only(top: ((containerHeight - 180) / 2) - 10.0),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  shape: BoxShape.circle,
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
                        color: Color.fromRGBO(255, 255, 255, 0.612)),
                    //presetFontSizes: [40, 20, 14],
                    //maxLines: 1,
                ),
              ],
            ),
          ),
          
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        activeIndex: 3,
      ),
    );
  }
}