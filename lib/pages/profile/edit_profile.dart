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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _neckController = TextEditingController();
  TextEditingController _waistController = TextEditingController();
  TextEditingController _hipsController = TextEditingController();
  TextEditingController _goalController = TextEditingController();
  TextEditingController _levelController = TextEditingController();
  TextEditingController _frequencyController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with current user data
    final user = widget.userProvider.user!;
    _usernameController.text = user.username;
    _emailController.text = user.email;
    _genderController.text = user.gender;
    _ageController.text = user.age.toString();
    _heightController.text = user.height.toString();
    _weightController.text = user.weight.toString();
    _neckController.text = user.neck.toString();
    _waistController.text = user.waist.toString();
    _hipsController.text = user.hips.toString();
    _goalController.text = user.goal;
    _levelController.text = user.level;
    _frequencyController.text = user.frequency;
    _durationController.text = user.duration;
    _timeController.text = user.time;
  }

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
                _buildTextField('New Username', _usernameController),
                SizedBox(height: 20),
                _buildTextField('Email', _emailController),
                SizedBox(height: 20),
                _buildTextField('Gender', _genderController),
                SizedBox(height: 20),
                _buildTextField('Age', _ageController),
                SizedBox(height: 20),
                _buildTextField('Height', _heightController),
                SizedBox(height: 20),
                _buildTextField('Weight', _weightController),
                SizedBox(height: 20),
                _buildTextField('Neck Circumference', _neckController),
                SizedBox(height: 20),
                _buildTextField('Waist Circumference', _waistController),
                SizedBox(height: 20),
                _buildTextField('Hip Circumference', _hipsController),
                SizedBox(height: 20),
                _buildTextField('Goal', _goalController),
                SizedBox(height: 20),
                _buildTextField('Level', _levelController),
                SizedBox(height: 20),
                _buildTextField('Frequency', _frequencyController),
                SizedBox(height: 20),
                _buildTextField('Duration', _durationController),
                SizedBox(height: 20),
                _buildTextField('Time', _timeController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Create a modified UserModel to update
                    UserModel updatedUser = UserModel(
                      uid: widget.userProvider.user!.uid,
                      username: _usernameController.text.trim(),
                      profileImageUrl: widget.userProvider.user!.profileImageUrl,
                      email: _emailController.text.trim(),
                      gender: _genderController.text.trim(),
                      age: int.tryParse(_ageController.text.trim()) ?? widget.userProvider.user!.age,
                      height: int.tryParse(_heightController.text.trim()) ?? widget.userProvider.user!.height,
                      weight: int.tryParse(_weightController.text.trim()) ?? widget.userProvider.user!.weight,
                      neck: int.tryParse(_neckController.text.trim()) ?? widget.userProvider.user!.neck,
                      waist: int.tryParse(_waistController.text.trim()) ?? widget.userProvider.user!.waist,
                      hips: int.tryParse(_hipsController.text.trim()) ?? widget.userProvider.user!.hips,
                      goal: _goalController.text.trim(),
                      level: _levelController.text.trim(),
                      frequency: _frequencyController.text.trim(),
                      duration: _durationController.text.trim(),
                      time: _timeController.text.trim(),
                    );

                    // Call updateUser method of the existing userProvider instance
                    await widget.userProvider.updateUser(updatedUser);

                    // Navigate back to the profile page with updated data
                    Navigator.pop(context);
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

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
