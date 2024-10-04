class ApiUrls {
  ApiUrls._();

  // static const String baseUrl = "http://144.91.80.25:1106/api/";
  // static const String imageBaseUrl = "http://144.91.80.25:1106/";

  static const String baseUrl = "https://scanmeapi.vinnisoft.org/api/";
  static const String imageBaseUrl = "https://scanmeapi.vinnisoft.org/";

  // static const String baseUrl = "https://api.scanmeplus.in/api/";
  // static const String imageBaseUrl = "https://api.scanmeplus.in/";

  static const checkMobileNumber = 'user/check-mobile-exist';
  static const requestOtp = 'user/request-otp';
  static const statedAndCityList = 'user/states-cities';
  static const checkEmail = 'user/check-email-exist';
  static const checkUserId = 'user/check-userid-exist';
  static const registerUser = 'user/signup';
  static const loginUser = 'user/login';
  static const userProfile = 'user/profile';
  static const updateUserProfile = 'user/profile';
  static const uploadFile = 'user/upload/file';

  static const vehicleBrandList = 'user/vehicle-list';
  static const myVehicle = 'user/vehicle';
  static const addVehicle = 'user/vehicle';
  static const vehicleSearch = 'user/vehicle-search';

  static const temporaryDeleteVehicle = 'user/vehicle/';
  static const permanentDeleteVehicle = 'user/vehicle/';

  static const scanVehicle = 'user/vehicle-scan';
  static const membershipPlan = 'user/plan?vehicleId=';
  static const subscribeMemberShipPlan = 'user/plan/subscribe';
  static const paymentSuccessful = 'user/plan/after-subscription';

  static const updateFcm = 'user/fcm';

  static const startCall = 'user/call';
  static const callListHistory = 'user/call/?callStatus=';
  static const deleteCall = 'user/call/';
  static const callDetail = 'user/call';
  static const callStatus = 'user/call';
  static const blockUnblockUser = 'user/block-unblock-user';

  static const emergencyAlerts = 'user/emergency-alert';
  static const sendAlerts = 'user/user-alert';

  static const addShippingAddress = 'user/shipping-address';
  static const shippingAddressList = 'user/shipping-address';

  static const replacementRequest = 'user/replacement-request';
  static const scanFeedback = 'user/scan-feedback';

  static const notificationList = 'user/notification';
  static const alertNotificationList = 'user/user-alert';
  static const deleteNotification = 'user/notification/';
  static const deleteAlertNotification = 'user/user-alert/';
  static const newNotification = 'user/notification-dot/';

  static const blockedUsersList = 'user/blocked-users';
  static const helpSupport = 'user/support';

  static const shippingOrder = 'user/order';
  static const shippingOrderStatus = 'user/order-status/';

  static const cancelSubscription = 'user/plan/cancel-subscription';
  static const upgradeSubscription = 'user/plan/upgrade-subscription';
  static const downloadInvoice = 'user/plan/invoice/';

  static const banner = 'user/banner';
  static const delteAccount = 'user/profile/';
  static const staticPages = 'static-page-by-title';
}
