/*
이벤트가 발생한 대상 알아내기
e.target: 이벤트가 발생했을 때 마우스 포인터 위치에 있는 요소를 반환

e.currentTarget: 이벤트가 발생했을 때 이벤트문 상에서 선택자 요소를 반환
*/
const main = document.querySelector("main");

main.addEventListener('click', (e) => {
  console.log(e.currentTarget);
  console.log(e.target);
})