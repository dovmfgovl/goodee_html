import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.1/firebase-app.js";
//import { initializeApp } from "firebase/app"; //로컬에 설치되어 있을 때 사용하기
//type = module 기억 - 모듈지원 - 자바스크립트 쪼개기 가능함
//여기서 생성된 객체는 어떻게 사용되죠?
  const firebaseConfig = { //객체 - 키: 값
    apiKey: "AIzaSyDiE9tJu_jKrPYKuzCF1IV8meen7FFclk8",
  authDomain: "mybook-bdba1.firebaseapp.com",
  projectId: "mybook-bdba1",
  storageBucket: "mybook-bdba1.appspot.com",
  messagingSenderId: "481378507898",
  appId: "1:481378507898:web:4411fcdb882423f6b8efc3"
  };

  // Initialize Firebase
  export const app = initializeApp(firebaseConfig);