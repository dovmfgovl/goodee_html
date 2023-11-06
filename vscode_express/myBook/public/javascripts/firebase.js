import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.1/firebase-app.js";

  const firebaseConfig = {
    apiKey: "AIzaSyBBkw2enzngeRv3XkJcvVufmUSfJNKZRmU",
    authDomain: "gd20230918-1ee16.firebaseapp.com",
    projectId: "gd20230918-1ee16",
    storageBucket: "gd20230918-1ee16.appspot.com",
    messagingSenderId: "508810326064",
    appId: "1:508810326064:web:7054c1abafe6f42c757df5"
  };

  // Initialize Firebase
  export const app = initializeApp(firebaseConfig);