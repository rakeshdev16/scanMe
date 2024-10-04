import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // onboarding
          'on_boarding_text1':
              'Spot a wrongly parked car? Take action easily with our app.',
          'on_boarding_text2': 'Scan QR to connect Instantly with Car Owner.',
          'on_boarding_text3':
              'Effortlessly reach car owner and clear the way quick call.',
          'next': 'Next',
          'skip': 'Skip',
          'get_started': 'Get Started',

          // login
          'login_introduction':
              'Connect Instantly, Resolve Quickly.',
          // 'login_introduction':
          //     'India\'s #1 Scan App where vehicle owners meet.',
          'mobile_number': 'Mobile Number',
          'enter_mobile_number': 'Enter Mobile Number',
          'get_otp': 'Get OTP',
          'agree_continue': 'By continuing, you agree to our\n',
          'privacy_policy': 'Privacy Policy',
          'content_policy': 'Content Policy',

          // otp verification
          'otp_introduction': 'We have sent a verification code to ',
          'enter_otp': 'Enter OTP',
          'did_not_get_otp': 'Didn\'t get the OTP? ',
          'resend_sms': 'Resend SMS',
          'go_back_to_login': 'Go back to login',
          'otp_does_not_match': 'Incorrect OTP',

          // add profile details
          'add_profile_details': 'Add profile details',
          'first_name': 'First Name',
          'last_name': 'Last Name',
          'email_address': 'Email Address',
          'user_id': 'User ID',
          'pincode': 'Pincode',
          'state': 'State',
          'city': 'City',
          'select': 'Select',
          'address': 'Address',
          'submit': 'Submit',
          'send': 'Send',
          'username_not_available':
              'This username already exists. Please try another.',
          'email_not_available':
              'This email id already exists. Please try another.',
          'message_server_error': 'Getting server error.Please try again!',

          // home
          'home': 'Home',
          'calls': 'Calls',
          'my_plans': 'My Plans',
          'scan_qr': 'Scan QR',
          'profile': 'Profile',
          'add_vehicle': 'Add Vehicle',
          'close': 'Close',
          'your_vehicle': 'Your Vehicle',
          'view_qr': 'View QR',
          'replacement': 'Replacement',
          'view_shipment': 'View shipment',
          'add_shipment': 'Add shipment',
          'delete': 'Delete',
          'retrieve': 'Retrieve',
          'inactive': 'Inactive',
          'search': 'Search',
          'enter_your_vehicle_number': 'Enter your vehicle number',
          'vehicle_number_information':
              'The vehicle number should match with your RC document.',
          'add_now': 'Add now',
          'oh_no_vehicle_not_found':
              'Uh-oh! Your vehicle details could not be fetched please enter details manually.',
          'add_details_manually': 'Add details manually',

          // choose vehicle type
          'choose_vehicle_type': 'Choose Vehicle Type',
          'wheeler': 'Wheeler',

          // choose vehicle brand
          'choose_vehicle_brand': 'Choose Vehicle Brand',
          'search_vehicle_brand': 'Search vehicle Brand',

          // choose vehicle model
          'choose_vehicle_model': 'Choose Vehicle Model',
          'search_your_vehicle_model': 'Search your vehicle model',

          // confirm vehicle details
          'confirm_details': 'Confirm Details',
          'brand': 'Brand',
          'model': 'Model',
          'vehicle_number': 'Vehicle Number',
          'vehicle_added_successfully':
              'Your vehicle has been added successfully.',
          'ok': 'OK',
          'delete_account': 'Delete Account',

          // upgrade plans
          'plans': 'Plans',
          'whats_included': 'What\'s Included',
          'premium': 'Premium',
          'instant_safety_alerts': 'Instant Safety Alerts',
          'in_app_calling_features': 'In App Calling Features',
          'effortless_vehicle_registration': 'Effortless Vehicle Registration',
          'smart_qr_code_scanning': 'Smart QR Code Scanning',
          'user_friendly_call_history': 'User-Friendly Call History',
          'tailored_subscription_plan': 'Tailored Subscription Plans',
          'upgrade_to_premium': 'Upgrade to Premium',

          // thanks you for choosing us
          'thankyou_for_choosing_us': 'Thank You For Choosing Us!',
          'proceed_with_executive': 'Proceed With Executive',
          'ship_to_your_location': 'Ship To Your Location',
          'sure_ship_to_location':
              'Are you sure you want to proceed with the shipment?',
          'yes': 'Yes',
          'no': 'No',

          // shipping address
          'shipping_address': 'Shipping Address',
          'sure_to_submit': 'Are you sure you want to Submit?',
          'qr_order_successful': 'Your QR code has been successfully placed.',

          // my plans
          'purchase_list': 'Purchase List',
          'active_plan': 'Active Plan',
          'expired_plan': 'Plan Expired',
          'upcoming_plan': 'Upcoming Plan',
          'download_invoice': 'Download Invoice',
          'monthly': 'Monthly',
          'next_billing_date': 'Next Billing Date',
          'show_more': 'Show more',
          'show_less': 'Show less',
          'membership_plans': 'Membership plans',
          'half_yearly': 'Half Yearly',
          'yearly': 'Yearly',
          'upgrade': 'Upgrade',
          'renew': 'Renew',
          'billing_details': 'Billing Details',
          'inr': '₹',
          'cancel_plan': 'Cancel Plan',
          'sure_to_cancel_plan': 'Are you sure you wan to cancel active plan?',

          // calls
          'all': 'All',
          'missed': 'Missed',
          'incoming': 'Incoming',
          'outgoing': 'Outgoing',
          'rejected': 'Declined',

          // bottom sheets
          'block': 'Block',
          'unblock': 'Unblock',
          'blocked_users': 'Blocked users',
          'emergency_alert': 'Emergency Alert',
          'sure_to_block': 'Are you sure you want to block?',
          'sure_to_unblock': 'Are you sure you want to Unblock?',
          'call': 'Call',

          // my profile
          'my_profile': 'My Profile',
          'account': 'Account',
          'refer_friend': 'Refer a Friend',
          'about': 'About',
          'society_hotel_signup': 'Join as Scan me community',
          'help_support': 'Help & Support',
          'logout': 'Logout',

          // edit profile
          'edit_profile': 'Edit Profile',
          'update_profile': 'Update Profile',

          // refer a friend
          'here_referral_link': 'Here\'s your referral link',
          'invite_whatsapp': 'Invite via WhatsApp',
          'other_share_options': 'Other share options',
          'how_it_works': 'How it works',
          'share': 'Share your referral link with your friend.',
          'download':
              'Maximize the app\'s benefits: download, verify, and unlock membership perks now.',
          'experience': 'Experience the app',

          // about
          'terms_of_use': 'Terms of Use',

          // logout
          'sure_logout': 'Are you sure you want to Logout?',
          'sure_delete': 'Are you sure you want to Delete Account?',

          // alert and Notifications
          'alert_notifications': 'Alert & Notifications',
          'alerts': 'Alerts',
          'notifications': 'Notifications',

          // help and support
          'full_name': 'Full Name',
          'comments': 'Comments',

          // scan qr
          'send_qr_feedback': 'Send QR feedback',
          'get_help': 'Get Help',
          'scan_to_connect_vehicle_owner':
              'Scan QR code to Contact vehicle Owner',
          'qr_not_working': 'QR not working?',
          'send_feedback_to_us': 'Send feedback to us',
          'not_now': 'Not now',
          'send_feedback': 'Send Feedback',
          'retake': 'Retake',
          'select_one_more_reason': 'Select 1 or more reason (optional)',
          'unscannable': 'Unscannable',
          'lighting': 'Lighting',
          'damaged': 'Damaged',
          'others': 'Others',
          'describe_this_qr_code': 'Describe this QR code',
          'please_mention_car': 'Please mention the Car no in feedback',
          'report_save_with_scan_me_plus':
              'Your report is safe with Scan Me. We\'ll use the info you give us to address technical issues and improve our service, subject to our ',
          'and': ' and ',
          'cancel': 'Cancel',
          'rescan': 'Rescan',

          // emergency alerts
          'emergency_alert_sent':
              'Your Emergency Alert has been sent Successfully.',

          // delete
          'temporary_deletion': 'Temporary Deletion',
          'temporary_deletion_info':
              'This option allows you to inactive incoming calls, but ut you\'ll still get alerts for wrong parking—stay informed without interruption!',
          'permanent_deletion': 'Permanent Deletion',
          'permanent_deletion_info':
              'This option removes data from the system permanently and irreversibly.',
          'temporary': 'Temporary',
          'permanent': 'Permanent',
          'sure_to_delete_temporary':
              'Are you sure you want to delete temporary?',
          'sure_to_delete_permanent':
              'Are you sure you want to delete permanently?',
          'vehicle_not_found': 'Vehicle not found',
          'enter_register_vehicle_number':
              'Please enter register vehicle number.',

          // replacement
          'select_reason': 'Select Reason',
          'select_address': 'Select Address',
          'add_new_address': 'Add new address',
          'select_reason_to_proceed': 'Select reason to proceed',
          'select_address_to_proceed': 'Select address to proceed.',

          // messages
          'no_data_available': 'No data available',

          // image
          'take_a_photo': 'Take a Photo',
          'choose_from_gallery': 'Choose from library',
          'no_image_clicked': 'No image clicked',
          'no_image_selected': 'No image selected',
          'no_image': 'No Image',

          // alert message
          'success': 'Success',
          'error': 'Error',
          'alert': 'Alert',

          // validations
          'email_cannot_be_empty': 'Email cannot be empty.',
          'enter_valid_email': 'Please enter a valid email.',
          'mobile_cannot_be_empty': 'Mobile number cannot be empty.',
          'enter_10_digit_mobile': 'Please enter a 10 digit mobile number.',
          'enter_valid_mobile': 'Please enter valid number.',
          'cannot_be_empty': 'cannot be empty.',

          // call
          'calling': 'Calling',
          'ringing': 'Ringing',
          'in_call_with': 'In Call with',
          'incoming_call': 'Incoming Call',

          'subscription_not_purchased': 'Subscription plan is not purchased for the vehicle.',
          'purchase_plan': 'Purchase Plan',
          'payment_failed': 'Payment Failed',

          'message_exit_app': 'Are you sure you want to exit the app?',
          'exit': 'Exit',
          'dismiss': 'Dismiss',
        }
      };
}
