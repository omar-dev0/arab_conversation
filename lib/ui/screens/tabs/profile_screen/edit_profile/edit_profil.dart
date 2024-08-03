import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/screens/tabs/profile_screen/profile_cubit/profile_view_model.dart';
import 'package:arab_conversation/ui/shared_widgets/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  ProfileViewModel profileViewModel = getIt.get<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        alignment: Alignment.bottomCenter,
        width: 375.w,
        height: 81.h,
        color: Color(0xFFECEDED),
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                profileViewModel.backToProfile();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            Expanded(
                child: SizedBox(
              width: double.infinity,
            )),
            Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Expanded(
                child: SizedBox(
              width: double.infinity,
            )),
            TextButton(
                onPressed: () async {
                  await profileViewModel.updateUser();
                },
                child: Text(
                  'Done',
                  style: Theme.of(context).textTheme.labelSmall,
                )),
          ],
        ),
      ),
      SizedBox(
        height: 84.h,
      ),
      CircleAvatar(
        radius: 48.h,
        backgroundImage: AssetImage('assets/images/profile.jpeg'),
      ),
      SizedBox(
        height: 8.h,
      ),
      Text(
        profileViewModel.user.name!,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      SizedBox(
        height: 32.h,
      ),
      Form(
          child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'First Name',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            ProfileTextField(controller: profileViewModel.firstName),
            SizedBox(
              height: 16.h,
            ),
            Text(
              'Last Name',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            ProfileTextField(controller: profileViewModel.lastName),
            SizedBox(
              height: 16.h,
            ),
            Text(
              'Email',
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            ProfileTextField(
              controller: profileViewModel.email,
              isEnabled: false,
            ),
          ],
        ),
      )),
    ]);
  }
}
