import 'package:arab_conversation/ui/screens/tabs/profile_screen/profile_cubit/profile_view_model.dart';
import 'package:arab_conversation/ui/shared_widgets/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserProfile extends StatefulWidget {

   const EditUserProfile({super.key });

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        alignment: Alignment.bottomCenter,
        width: 375.w,
        height: 81.h,
        color: const Color(0xFFECEDED),
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<ProfileViewModel>(context).backToProfile();
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            const Expanded(
                child: SizedBox(
              width: double.infinity,
            )),
            const Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const Expanded(
                child: SizedBox(
              width: double.infinity,
            )),
            TextButton(
                onPressed: () async {
                  await BlocProvider.of<ProfileViewModel>(context).updateUser();
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
        backgroundImage: const AssetImage('assets/images/profile.jpeg'),
      ),
      SizedBox(
        height: 8.h,
      ),
      Text(
        BlocProvider.of<ProfileViewModel>(context).user.name!,
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
            ProfileTextField(controller: BlocProvider.of<ProfileViewModel>(context).firstName),
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
            ProfileTextField(controller: BlocProvider.of<ProfileViewModel>(context).lastName),
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
              controller: BlocProvider.of<ProfileViewModel>(context).email,
              isEnabled: false,
            ),
          ],
        ),
      )),
    ]);
  }
}
