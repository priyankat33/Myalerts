
//

//

import Foundation


struct ValidationMessage {
     static let kSelectProfileImage = "Please select Profile image"
    static let kFirstName = "Bitte Vornamen eingeben"
    static let kTitle = "Please enter title"
    static let kCaption = "Please enter caption"
    
     static let kFirstNameAlphabatics = "First name contains only alphabatics"
     static let kLastNameAlphabatics = "Last name contains only alphabatics"
    static let kLastName = "Bitte Nachname eingeben"
    static let kEmail = "Bitte E-Mail eingeben"
    static let kUsername = "Please enter name"
    
    static let kSelected = "Please select atleast one service"
    
    static let kSelectedTime = "Please select time"
    
    static let kReview = "Please enter review"
    static let kRating = "Please select rating"
    
    static let kSelectedLocation = "Please select location"
    
    static let kSelectImage = "Please select image"
    static let kUsernameValidation = "Please enter only alphabets in name"
    
    static let kUsernameCount = "The name should not be more than 25 characters"
  
    static let kValidEmail = "Please enter a valid email"
    static let kPassword = "Bitte Passwort eingeben"
     static let kPhone = "Please enter phone number"
    static let kOldPassword = "Please enter the old password"
    static let kPasswordLength = "Password should be minimum of 8 characters and maximum of 30 characters"
    
    static let kPhoneLength = "Phone number should be minimum of 10 digits and maximum of 15 digits"
    static let kNewPassword = "Please enter new password"
    static let kConfirmPassword = "Bitte geben Sie Ihr Passwort ein"
    static let kPasswordNotMatch = "Kennwort und Bestätigungskennwort stimmen nicht überein"
    
    static let kOldPasswordNotMatch = "Old password and new password shuold not be same"
    static let kTermsConditions = "Please accept Terms & Conditions"
    
    
    static let kCardName = "Please enter the card holder name"
    static let kCardNumber = "Please enter card number"
    static let kExpiration = "Please enter expiration date"
    static let kCVV = "Please enter CVV"
    
    static let kOTP = "Please enter OTP"
    
}


struct API {
    
    static let kSendPasswordResetLink = "user/v1/forgot-password"
    static let kLogin      =   "login"
    static let kAddKpi      =   "add_kpi"
    static let kKpiTypesListing      =   "kpi_types_listing"
    

    static let kKpiListing =  "kpi_listing"
    static let kNotification =  "get_notifications"
    static let kMarkNotificationSeen =  "mark_notification_seen"
    static let kGetUserPackage = "get_user_package"
    static let kAddUserPackage = "add_user_package"
    static let kCancelUserPackage = "cancel_user_package"
    static let kGenerateAgencyCode = "generate_agency_code"
    
    static let kHome   =   "page/v1/home"
    static let kDeleteKpi   =   "delete_kpi"
    static let kForgotPassword = "forgot_password"
    static let kChangePassword = "change_password"
    static let kEditProfile = "edit_profile"
    static let kSignUp     =   "signup"
    static let kSignUpNew     =   "signup_new"
    static let kProfileInfo = "profile_info"
    static let kVerifyEmail     =   "verify_email"
    static let kResendOTP     =   "resend_otp"
    static let kVerifyAgencyCode     =   "verify_agency_code"
    static let kAgencyCodeLabel     =   "agency_code_label"
    static let kDeleteAccount = "delete_my_account"
   
}
