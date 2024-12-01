// how to send notification on firebase
// 1-install gcloud with link //https://cloud.google.com/sdk/docs/install
// 2- get project id for each flavor
// 3-get private key json file from service account from project setting on firebase
// 4-run this commad to get token//gcloud auth activate-service-account --key-file="C:\Users\Sefen\Downloads\cityeye-7c456-firebase-adminsdk-tvftp-8e96c96b32.json"
// then run this
//  gcloud init --skip-diagnostics
// then
// gcloud config set project cityeye-7c456
// then run
// gcloud auth print-access-token
// then add it to header request
//
// //end poit
// https://fcm.googleapis.com/v1/projects/303235547553/messages:send
// //authorization
// Bearer Token         token access_token
// //header
// Authorization   key =access_token
// Content-Type    application/json
// //body
//
// {
//   "message": {
//     "token": "dUMSP-ZqTnCYBEXfLjT141:APA91bELI6c5xqh3FHGb0elM84J3AfuSzU2h93Ej4q0vxFHrzCY_NgEJD4dIyqTp7REsrilna6b9m7JBUYXDGjYNo1ZXElZNs_nYMwcydS2Ait7IbOlc84A",
//     "notification": {
//       "title": "Test Notification",
//       "body": "This is a test notification"
//     }
//   }
// }
