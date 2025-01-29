const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendPushNotification = functions.database
  .ref('/busses/-O2N7RsBHeEt31DME-6u/status')
  .onUpdate((change) => {
    const newStatus = change.after.val();
    const payload = {
        notification: {
          title: 'Journey Status Update',
          body: `Your child’s journey status has changed to: ${newStatus}`,
          clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
      };

      // Get the list of tokens (e.g., from your Firebase Database)
      const tokens = ['fy7ACk-sTpyEWvmwaQmIDJ:APA91bF-dEoDiwGAVXuFAM7XcFz4qB0fjpQAdaXebhHRj-GSvDXaoAvLIbtzoWhySRAKv0FpKGVYzemTcvZM1AHB8XpRS4lmDZ6LxMHYhBMMqF8tuaaj7fCkzvxqZnKsiimFj7eypKdb'];

      // Send notifications to all tokens
      return admin.messaging().sendToDevice(tokens, payload)
        .then(response => {
          console.log('Successfully sent message:', response);
        })
        .catch(error => {
          console.log('Error sending message:', error);
        });
});

exports.sendPushNotification2 = functions.database
  .ref('/busses/-O4Dvpg_AhWGNNYuLMMi/status')
  .onUpdate((change) => {
    const newStatus = change.after.val();
    const payload = {
        notification: {
          title: 'Journey Status Update',
          body: `Your child’s journey status has changed to: ${newStatus}`,
          clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
      };

      // Get the list of tokens (e.g., from your Firebase Database)
      const tokens = ['fy7ACk-sTpyEWvmwaQmIDJ:APA91bF-dEoDiwGAVXuFAM7XcFz4qB0fjpQAdaXebhHRj-GSvDXaoAvLIbtzoWhySRAKv0FpKGVYzemTcvZM1AHB8XpRS4lmDZ6LxMHYhBMMqF8tuaaj7fCkzvxqZnKsiimFj7eypKdb'];

      // Send notifications to all tokens
      return admin.messaging().sendToDevice(tokens, payload)
        .then(response => {
          console.log('Successfully sent message:', response);
        })
        .catch(error => {
          console.log('Error sending message:', error);
        });
});

exports.sendPushNotification5min = functions.database
  .ref('/busses/-O2N7RsBHeEt31DME-6u/alert')
  .onUpdate((change) => {
    const newStatus = change.after.val();
    const payload = {
        notification: {
          title: 'Journey Status Update',
          body: `Your child’s bus is ${newStatus} mins away`,
          clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
      };

      // Get the list of tokens (e.g., from your Firebase Database)
      const tokens = ['fy7ACk-sTpyEWvmwaQmIDJ:APA91bF-dEoDiwGAVXuFAM7XcFz4qB0fjpQAdaXebhHRj-GSvDXaoAvLIbtzoWhySRAKv0FpKGVYzemTcvZM1AHB8XpRS4lmDZ6LxMHYhBMMqF8tuaaj7fCkzvxqZnKsiimFj7eypKdb'];

      // Send notifications to all tokens
      return admin.messaging().sendToDevice(tokens, payload)
        .then(response => {
          console.log('Successfully sent message:', response);
        })
        .catch(error => {
          console.log('Error sending message:', error);
        });
});

exports.sendPushNotification25min = functions.database
  .ref('/busses/-O4Dvpg_AhWGNNYuLMMi/alert')
  .onUpdate((change) => {
    const newStatus = change.after.val();
    const payload = {
        notification: {
          title: 'Journey Status Update',
          body: `Your child’s bus is ${newStatus} mins away`,
          clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
      };

      // Get the list of tokens (e.g., from your Firebase Database)
      const tokens = ['fy7ACk-sTpyEWvmwaQmIDJ:APA91bF-dEoDiwGAVXuFAM7XcFz4qB0fjpQAdaXebhHRj-GSvDXaoAvLIbtzoWhySRAKv0FpKGVYzemTcvZM1AHB8XpRS4lmDZ6LxMHYhBMMqF8tuaaj7fCkzvxqZnKsiimFj7eypKdb'];

      // Send notifications to all tokens
      return admin.messaging().sendToDevice(tokens, payload)
        .then(response => {
          console.log('Successfully sent message:', response);
        })
        .catch(error => {
          console.log('Error sending message:', error);
        });
});