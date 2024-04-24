import 'package:flutter/material.dart';
import '../model/friend.dart';
import 'package:provider/provider.dart';

import '../provider/friendsList_provider.dart';

class SlamBook extends StatefulWidget {
  const SlamBook({Key? key}) : super(key: key);

  @override
  State<SlamBook> createState() => _SlamBookState();
}

class _SlamBookState extends State<SlamBook> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<bool>> _statusFieldKey =
      GlobalKey<FormFieldState<bool>>();
  final GlobalKey<FormFieldState<double>> _happinessLevelFieldKey =
      GlobalKey<FormFieldState<double>>();
  final GlobalKey<FormFieldState<String>> _radioFieldKey =
      GlobalKey<FormFieldState<String>>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final bool _validate = false;
  bool summaryVisible = false; // Visible check for summary

  static final List<String> _superpowerDropdownOptions = [
    "Makalipad",
    "Maging Invisible",
    "Mapaibig siya",
    "Mapabago ang isip niya",
    "Mapalimot siya",
    "Mabalik ang nakaraan",
    "Mapaghiwalay sila",
    "Makarma siya",
    "Mapasagasaan siya sa pison",
    "Mapaitim ang tuhod ng iniibig niya"
  ];

  static final Map<String, bool> _mottoRadioOptions = {
    "Haters gonna hate": true,
    "Bakers gonna Bake": false,
    "If cannot be, borrow one from three": false,
    "Less is more, more or less": false,
    "Better late than sorry": false,
    "Don't talk to strangers when your mouth is full": false,
    "Let's burn the bridge when we get there": false
  };

  Friend friend = Friend(
      '',
      '',
      '',
      false,
      50.0,
      _superpowerDropdownOptions.first,
      _mottoRadioOptions.keys
          .firstWhere((k) => _mottoRadioOptions[k] == true, orElse: () => ''));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  // Widget that builds TextFormField() given a label and controller
  // ** Validates String input
  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          // Highlight red on validation error
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          labelText: label,
          errorText: _validate ? 'Value can\'t be empty' : null,
          fillColor: Colors.white,
          filled: true,
        ),
        validator: (value) {
          //validates if value in controller/textfield is not empty
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  // Widget that builds TextFormField() given a label and controller
  // ** Validates Int input
  Widget buildTextFieldInt(String label, TextEditingController _controller) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 10),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          labelText: label,
          errorText: _validate ? 'Value can\'t be empty' : null,
          fillColor: Colors.white,
          filled: true,
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          //validates if value in controller/textfield is not empty
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          } else if (int.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }

  Widget buildStatusSwitch() {
    return FormField<bool>(
      key: _statusFieldKey,
      builder: (state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 150, child: buildTextFieldInt("Age", _ageController)),
            const Text('In a relationship?'),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Switch(
                value: friend.isInARelationship,
                onChanged: (value) {
                  setState(() {
                    friend.isInARelationship = value;
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildHappinessSlider() {
    return Column(
      children: [
        const ListTile(
          title: Center(child: Text("Happiness Level")),
          subtitle:
              Center(child: Text("On a scale of 1-happy how happy are you?")),
        ),
        FormField<double>(
          key: _happinessLevelFieldKey,
          builder: (state) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Slider(
                    value: state.value ?? friend.happiness,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: (value) {
                      state.didChange(value); // Update the FormField state
                      setState(() {
                        friend.happiness =
                            value; // Update local state for displaying current value
                      });
                    },
                  ),
                ),
                Text(friend.happiness.round().toString()),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget buildSuperpowerDropdown() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Column(
        children: [
          const ListTile(
            title: Center(child: Text("Superpower")),
            subtitle: Center(child: Text("subtitle")),
          ),
          DropdownButtonFormField(
            value: friend.superpower,
            onChanged: (value) {
              setState(() {
                friend.superpower = value!;
              });
            },
            items: _superpowerDropdownOptions.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onSaved: (newValue) {
              print("Saved new superpower");
            },
          ),
        ],
      ),
    );
  }

  Widget buildMottoRadioButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Column(
        children: [
          const Text("Motto"),
          FormField<String>(
            key: _radioFieldKey,
            initialValue: _mottoRadioOptions.keys.firstWhere(
                (k) => _mottoRadioOptions[k] == true,
                orElse: () => ''),
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _mottoRadioOptions.keys.map((option) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: option,
                        groupValue: friend.motto,
                        onChanged: (value) {
                          state.didChange(value);
                          setState(() {
                            friend.motto = value!;
                          });
                        },
                      ),
                      Text(option),
                    ],
                  );
                }).toList(),
              );
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Summary of User Details:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text('Name: ${friend.name}', style: TextStyle(fontSize: 16)),
        Text('Nickname: ${friend.nickname}', style: TextStyle(fontSize: 16)),
        Text('Age: ${friend.age}', style: TextStyle(fontSize: 16)),
        Text(
            'Status: ${friend.isInARelationship ? 'In a relationship' : 'Single'}',
            style: TextStyle(fontSize: 16)),
        Text('Happiness Level: ${friend.happiness.round().toString()}',
            style: TextStyle(fontSize: 16)),
        Text('Superpower: ${friend.superpower}',
            style: TextStyle(fontSize: 16)),
        Text('Motto: ${friend.motto}', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
      ],
    );
  }

  // Shows summary of user details
  void _saveSummary() {
    setState(() {
      friend.name = _nameController.text;
      friend.nickname = _nicknameController.text;
      friend.age = _ageController.text;

      summaryVisible = true;
    });
  }

  Widget buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Form is valid, show summary
          _saveSummary();
        }
      },
      child: const Text('Done'),
    );
  }

  // Reset input fields to default
  // ** Find way to automatically reset from {_formKey}
  Widget buildResetButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _formKey.currentState?.reset();

            _nameController.text = '';
            _nicknameController.text = '';
            _ageController.text = '';
            friend = Friend(
                '',
                '',
                '',
                false,
                50.0,
                _superpowerDropdownOptions.first,
                _mottoRadioOptions.keys.firstWhere(
                    (k) => _mottoRadioOptions[k] == true,
                    orElse: () => ''));
            summaryVisible = false;
          });
        },
        child: const Text("Reset"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Slambook")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Form is valid, show summary
            _saveSummary();
            print('Name: ${_nameController.text}');
            print('Nickname: ${_nicknameController.text}');
            print('Age: ${_ageController.text}');
            print(
                'Status: ${friend.isInARelationship ? 'In a relationship' : 'Single'}');
            print('Happiness Level: ${friend.happiness}');
            print('Superpower: ${friend.superpower}');
            print('Motto: ${friend.motto}');
            context.read<FriendsList>().addFriend(friend);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${friend.name} added!"),
              duration: const Duration(seconds: 1, milliseconds: 100),
            ));

            Navigator.pop(context, friend);
          }
        },
        child: const Icon(Icons.person_add_outlined),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),

              // INPUT FIELDS
              buildTextField("Name", _nameController),
              buildTextField("Nickname", _nicknameController),
              buildStatusSwitch(),
              buildHappinessSlider(),
              buildSuperpowerDropdown(),
              buildMottoRadioButtons(),

              // SUBMIT AND RESET BUTTON
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSaveButton(),
                  const SizedBox(
                    width: 30,
                  ),
                  buildResetButton(),
                ],
              ),

              // SHOW SUMMARY AREA
              if (summaryVisible) Container(child: buildSummary()),
            ],
          ),
        ),
      ),
    );
  }
}
