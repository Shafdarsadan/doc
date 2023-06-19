import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/firebase_user.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage();

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String _profileImagePath = '';

  Future<void> _selectProfilePicture() async {
    final PermissionStatus permissionStatus = await _requestStoragePermission();
    if (permissionStatus.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _profileImagePath = image.path;
        });
      }
    } else {
      // Handle permission denied
      if (permissionStatus.isDenied) {
        // Show a dialog or snackbar to inform the user about the permission denial
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('Permission Denied'),
        //       content: Text(
        //           'Please grant storage permission to select a profile picture.'),
        //       actions: [
        //         ElevatedButton(
        //           child: Text('OK'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      } else {
        await Permission.storage.request();
      }
    }
  }

  Future<PermissionStatus> _requestStoragePermission() async {
    final PermissionStatus permission = await Permission.storage.request();
    return permission;
  }

  grabuserdata() async {
    final ref = await FirebaseFirestore.instance
        .collection('patient')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    FirebaseUser user = FirebaseUser.fromDoc(await ref.get());

    setState(() {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneNumberController.text = user.phone;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Permission.storage.request();
    grabuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       Container(
              //         width: 120.0,
              //         height: 120.0,
              //         decoration: BoxDecoration(
              //           color: Color(0xff0DA90B),
              //           shape: BoxShape.circle,
              //         ),
              //         child: _profileImagePath.isEmpty
              //             ? IconButton(
              //                 icon: Icon(
              //                   Icons.edit,
              //                   color: Colors.white,
              //                 ),
              //                 onPressed: _selectProfilePicture,
              //               )
              //             : null,
              //       ),
              //       _profileImagePath.isNotEmpty
              //           ? ClipRRect(
              //               borderRadius: BorderRadius.circular(60.0),
              //               child: Image.file(
              //                 File(_profileImagePath),
              //                 width: 120.0,
              //                 height: 120.0,
              //                 fit: BoxFit.cover,
              //               ),
              //             )
              //           : SizedBox(),
              //     ],
              //   ),
              // ),
              SizedBox(height: 16.0),
              Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                textFieldController: _nameController,
                hintText: 'Username',
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                textFieldController: _emailController,
                hintText: 'example@abc.com',
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              Text(
                'Phone Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                textFieldController: _phoneNumberController,
                hintText: '+91 92XX XXXX XX',
                inputType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final ref = await FirebaseFirestore.instance
                      .collection('patient')
                      .doc(FirebaseAuth.instance.currentUser!.uid);
                  // await FirebaseAuth.instance.currentUser
                  //     ?.updateEmail(_emailController.text);
                  await ref.update({
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'phone': _phoneNumberController.text,
                  }).whenComplete(() => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("updated profle"))));
                  Navigator.popUntil(context, (route) => route.isFirst);

                  // Implement logic to update profile
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.textFieldController,
    this.isVisible = false,
    this.suffixIcon = const Icon(Icons.ac_unit),
    this.hintText = '',
    this.lineNo = 1,
    this.isPassword = false,
    this.isemail = false,
    this.inputType = TextInputType.streetAddress,
    this.inputColor = Colors.white,
  });

  final TextEditingController textFieldController;
  final bool isVisible;
  final Icon suffixIcon;
  final String hintText;
  final int lineNo;
  final bool isPassword;
  final bool isemail;
  final TextInputType inputType;
  final Color inputColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      color: Color(0xFF1E1F23),
      child: TextFormField(
        autofillHints: widget.isPassword
            ? [AutofillHints.password]
            : widget.isemail
                ? [AutofillHints.username]
                : null,
        keyboardType: widget.inputType,
        obscureText: obsecure && widget.isPassword,
        maxLines: widget.lineNo,
        style: TextStyle(color: widget.inputColor),
        controller: widget.textFieldController,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            left: 20,
            top: 12,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF2CC66D), width: 2.0),
            // borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: widget.hintText,
          suffixIcon: Visibility(
            visible: widget.isPassword,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    obsecure = !obsecure;
                  });
                },
                icon: obsecure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility)),
          ),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
