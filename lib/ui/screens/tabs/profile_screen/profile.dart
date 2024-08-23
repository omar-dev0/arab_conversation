import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/dialogs/dialog.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login.dart';
import 'package:arab_conversation/ui/screens/tabs/profile_screen/edit_profile/edit_profil.dart';
import 'package:arab_conversation/ui/screens/tabs/profile_screen/profile_cubit/profile_state.dart';
import 'package:arab_conversation/ui/screens/tabs/profile_screen/profile_cubit/profile_view_model.dart';
import 'package:arab_conversation/ui/shared_widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
   Profile({super.key});

  final ProfileViewModel profileViewModel = getIt.get<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => profileViewModel,
      child: BlocConsumer<ProfileViewModel, ProfileState>(
          listener: (context, state) {
        if (state is ErrorUpdateProfile) {
          closeDialog(context);
          showCustomDialog(
            context,
            icon: Icon(
              Icons.error,
              color: Colors.red,
              size: 35.sp,
            ),
            content: Text(
              state.error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF7D848D), fontSize: 16),
            ),
            negative: () {
              Navigator.pop(context);
            },
            negativeText: 'ok',
          );
        }
        else if (state is SuccessUpdateProfile) {
          closeDialog(context);
          showCustomDialog(context,
              icon: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const ImageIcon(
                    AssetImage('assets/icons/email.png'),
                    color: Colors.white,
                  )),
              title: Text(
                state.text,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              positiveText: 'Ok', positive: () {
            Navigator.pop(context);
          });
        }
        else if (state is LoadingUpdateProfile) {
          loadingDialog(context);
        }
        else if (state is SignOut) {
          Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (Route route) => false);

        }
      }, builder: (context, state) {
        if (state is InitState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: 375.w,
                height: 81.h,
                color: const Color(0xFFECEDED),
                padding: EdgeInsets.only(bottom: 8.h),
                child: const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
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
                profileViewModel.user.name!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                profileViewModel.user.email!,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, color: const Color(0xFF7D848D)),
              ),
              SizedBox(
                height: 60.h,
              ),
              CustomContainer(
                press: profileViewModel.togelScreens,
                icon: 'assets/icons/edit.png',
                text: 'Edit Profile',
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomContainer(
                icon: 'assets/icons/signout.png',
                text: 'Log out',
                press: profileViewModel.signOut,
              ),
            ],
          );
        }
        else if (state is EditProfile ) {
          return  EditUserProfile();
        }
        else if (state is SuccessUpdateProfile)
          {
            return  EditUserProfile();
          }
        else {
          return const Column();
        }
      }),
    );
  }
}
