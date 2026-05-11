importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: 'AIzaSyD6ivCmSqqQCocNOmGJqqBpzpAr7VM9hzE',
  authDomain: 'car-rent-8dde7.firebaseapp.com',
  projectId: 'car-rent-8dde7',
  storageBucket: 'car-rent-8dde7.firebasestorage.app',
  messagingSenderId: '479804461302',
  appId: '1:479804461302:web:240cc998852a652e1e9cd7',
  measurementId: 'G-DQJ0SWZ512',
});

const messaging = firebase.messaging();

// Background notifications keep chat/review triggers visible on web.
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const notificationTitle = payload.notification?.title ?? 'Car Rent';
  const notificationOptions = {
    body: payload.notification?.body ?? 'You have a new update.',
    icon: '/icons/Icon-192.png',
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});