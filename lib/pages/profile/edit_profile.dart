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

  List<String> genderOptions = ['Male', 'Female'];
  List<String> goalOptions = ['Lose Weight', 'Gain Weight', 'Get Fit'];
  List<String> levelOptions = ['Beginner', 'Intermediate', 'Advanced'];
  List<String> frequencyOptions = [
    '1-2 times a week',
    '3-4 times a week',
    '5-6 times a week'
  ];
  List<String> durationOptions = ['30 minutes', '60 minutes', '120 minutes'];

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
        title: Text('Edit Profile',
            style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildTextField('New Username', _usernameController),
                SizedBox(height: 20),
                _buildTextField('Email', _emailController),
                SizedBox(height: 20),
                _buildDropdown('Gender', _genderController, genderOptions),
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
                _buildDropdown('Goal', _goalController, goalOptions),
                SizedBox(height: 20),
                _buildDropdown('Level', _levelController, levelOptions),
                SizedBox(height: 20),
                _buildDropdown(
                    'Frequency', _frequencyController, frequencyOptions),
                SizedBox(height: 20),
                _buildDropdown(
                    'Duration', _durationController, durationOptions),
                SizedBox(height: 20),
                _buildTimePicker('Time', _timeController, context),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Create a modified UserModel to update
                    UserModel updatedUser = UserModel(
                      uid: widget.userProvider.user!.uid,
                      username: _usernameController.text.trim(),
                      profileImageUrl:
                          widget.userProvider.user!.profileImageUrl,
                      email: _emailController.text.trim(),
                      gender: _genderController.text.trim(),
                      age: int.tryParse(_ageController.text.trim()) ??
                          widget.userProvider.user!.age,
                      height: int.tryParse(_heightController.text.trim()) ??
                          widget.userProvider.user!.height,
                      weight: int.tryParse(_weightController.text.trim()) ??
                          widget.userProvider.user!.weight,
                      neck: int.tryParse(_neckController.text.trim()) ??
                          widget.userProvider.user!.neck,
                      waist: int.tryParse(_waistController.text.trim()) ??
                          widget.userProvider.user!.waist,
                      hips: int.tryParse(_hipsController.text.trim()) ??
                          widget.userProvider.user!.hips,
                      goal: _goalController.text.trim(),
                      level: _levelController.text.trim(),
                      frequency: _frequencyController.text.trim(),
                      duration: _durationController.text.trim(),
                      time: _timeController.text.trim(),
                      favorites: widget.userProvider.user!.favorites,
                      completedDays: widget.userProvider.user!.completedDays,
                    );

                    // Call updateUser method of the existing userProvider instance
                    await widget.userProvider.updateUser(updatedUser);

                    // Navigate back to the profile page with updated data
                    Navigator.pop(context);
                  },
                  child: Text('Update User',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.background,
                      )),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                )
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
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            )),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ))),
      ),
    );
  }

  Widget _buildDropdown(String labelText, TextEditingController controller,
      List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField<String>(
        value: controller.text,
        onChanged: (newValue) {
          setState(() {
            controller.text = newValue!;
          });
        },
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        dropdownColor: Theme.of(context).colorScheme.background,
      ),
    );
  }

  Widget _buildTimePicker(String labelText, TextEditingController controller,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () async {
          TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
          );
          if (selectedTime != null) {
            setState(() {
              controller.text = selectedTime.format(context);
            });
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                controller.text.isNotEmpty ? controller.text : 'Select Time',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              Icon(Icons.access_time,
                  color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
