// 원시자료형
//상수 선언하기
const num1 = 1;
const num2 = 2;
console.log(num1 +1);
console.log(typeof(num1 +1)); //instanceOf 연산자
console.log(num1+num2);
console.log(typeof(num1+null));
console.log(num1+undefined); //Not a Number
console.log(typeof(num1+undefined)); //Not a Number
console.log(num1-num2);
/*
* : java에 없는 내용

자료형(Data Type)
원시형 자료(primative type) - 특정값이 메모리에 바로 저장(값만)
1. 문자(String)
2. 숫자(Number)
3. 논리형(Boolean : true, false)
//개발자 센터에서 자주 출몰함 - 디버깅 - 리스크
* 4. undefined : 변수를 선언하고 그 값을 할당하지 않으면 undefined가 대신 저장됨(에러상황) - NullPointerException

참조형 자료(reference type) - 값이 위치하고 있는 참조주소 값만 메모리에 저장
-> *관련된 내장함수(prototype)까지도 같이 참조됨
* 5. null(Object) : 명시적으로 특정 변수의 값을 비워둘 때
* 6. array(Object) : 연관된 값들을 그룹으로 묶어서 관리하는 형태
* 7. 객체(Object) : Object 데이터를 key라는 인덱싱을 통해 자료를 구조적으로 묶어놓은 상태(Map같은 느낌임)
    6, 7, JSON의 차이를 알고 왔다갔다, 섞어쓸 수 있어야 함
    목록처리시: array -> json, json -> array 필수!! 
*/