// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/dao/course_dao.dart' as _i4;
import '../data/dao/user_dao.dart' as _i3;
import '../data/data_contract/auth_contract.dart' as _i7;
import '../data/data_contract/course_contact.dart' as _i5;
import '../data/data_implementation/auth_imp.dart' as _i8;
import '../data/data_implementation/course_imp.dart' as _i6;
import '../data/repository/auth_repo.dart' as _i11;
import '../data/repository/course_repo.dart' as _i9;
import '../data/repository_imp/auth_repo_imp.dart' as _i12;
import '../data/repository_imp/course_repo_imp.dart' as _i10;
import '../ui/app_cubit.dart' as _i19;
import '../ui/screens/authintication_screens/forget_password/forget_password_cubit/forget_password_view_model.dart'
    as _i16;
import '../ui/screens/authintication_screens/login/login_cubit/login_cubit.dart'
    as _i18;
import '../ui/screens/authintication_screens/register/register_cubit/register_cubit.dart'
    as _i17;
import '../ui/screens/payment/payment_cubit/pay_view_model.dart' as _i14;
import '../ui/screens/tabs/home_screen/home_cubit/home_cubit.dart' as _i13;
import '../ui/screens/tabs/profile_screen/profile_cubit/profile_view_model.dart'
    as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.UserDao>(() => _i3.UserDao());
    gh.singleton<_i4.CourseDao>(() => _i4.CourseDao(gh<_i3.UserDao>()));
    gh.factory<_i5.CourseDataSource>(
        () => _i6.CourseDataSourceImp(gh<_i4.CourseDao>()));
    gh.factory<_i7.AuthSystem>(() => _i8.AuthSystemImp(gh<_i3.UserDao>()));
    gh.singleton<_i9.CourseRepo>(
        () => _i10.CourseRepoImp(gh<_i5.CourseDataSource>()));
    gh.singleton<_i11.AuthRepo>(() => _i12.AuthRepoImp(gh<_i7.AuthSystem>()));
    gh.factory<_i13.HomeViewModel>(() => _i13.HomeViewModel(
          gh<_i9.CourseRepo>(),
          gh<_i11.AuthRepo>(),
        ));
    gh.factory<_i14.PaymentViewModel>(() => _i14.PaymentViewModel(
          gh<_i9.CourseRepo>(),
          gh<_i11.AuthRepo>(),
        ));
    gh.factory<_i15.ProfileViewModel>(
        () => _i15.ProfileViewModel(gh<_i11.AuthRepo>()));
    gh.factory<_i16.ForgetPasswordViewModel>(
        () => _i16.ForgetPasswordViewModel(gh<_i11.AuthRepo>()));
    gh.factory<_i17.RegisterViewModel>(
        () => _i17.RegisterViewModel(gh<_i11.AuthRepo>()));
    gh.factory<_i18.LoginViewModel>(
        () => _i18.LoginViewModel(gh<_i11.AuthRepo>()));
    gh.factory<_i19.AppViewModel>(() => _i19.AppViewModel(
          gh<_i11.AuthRepo>(),
          gh<_i9.CourseRepo>(),
        ));
    return this;
  }
}
