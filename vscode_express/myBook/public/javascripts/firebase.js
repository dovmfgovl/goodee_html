import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.1/firebase-app.js";
//1. initialzeApp함수는 firebase-app.js에서 제공하는 함수이다.
//import { initializeApp } from "firebase/app"; //로컬에 설치되어 있을 때 사용하기
//type = module 기억 - 모듈지원 - 자바스크립트 쪼개기 가능함
//여기서 생성된 객체는 어떻게 사용되죠?
//apiKey: AIzaSyBie5qlyMDwHSSyOl0uSH_mRqFecVNNzSc
//2. firebase console에서 mybook이라는 이름으로 플젝을 생성하면 키와 기타 정보들을 제공해줌
  const firebaseConfig = { //나는 Object다 - 클래스는 아님
    //객체 - 키: 값
    apiKey: "AIzaSyDiE9tJu_jKrPYKuzCF1IV8meen7FFclk8",
    authDomain: "mybook-bdba1.firebaseapp.com",
    projectId: "mybook-bdba1",
    storageBucket: "mybook-bdba1.appspot.com",
    messagingSenderId: "481378507898",
    appId: "1:481378507898:web:4411fcdb882423f6b8efc3"
  };

  // Initialize Firebase - 파이어베이스 플젝을 활용하여 웹서비스 제공받기 위한 초기화 작업
  // 앞에 export를 붙여야 외부에서 사용 가능함('ES6 모듈' 찾아보기)
  // <script type=module></script>
  export const app = initializeApp(firebaseConfig);