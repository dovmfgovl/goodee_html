//변수 선언 방법 : let - 변하는 값 선언 시, const - 상수 선언 시
//const 선언은 블록 범위의 상수를 선언합니다. 상수의 값은 재할당할 수 없으며 다시 선언할 수도 없습니다.
const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장 객체임
const NEWS_URL = 'https://api.hnpwa.com/v0/news/1.json';
//open은 XMLHttpRequest 객체가 제공하는 함수로 파라미터는 3개가 필요함
//1) 전송방식 2) 요청하는 URL 3) true: 비동기, false: 동기 처리로 요청해 줌
//ajax변수는 XMLHttpRequest를 참조하는 변수명임
ajax.open('GET', NEWS_URL, false);
ajax.send(); //send() 호출될 때 비로소 서버측에 요청이 일어남

const newsList = JSON.parse(ajax.response); //위에서 요청했을 때 서버측의 응답을 받아오는 속성이 response임
console.log(newsList); //서버측에서 보낸 응답을 출력해보기 - Array로 변환하여 출력해줌
const ul = document.createElement('ul'); //DOM API 가지고 태그를 만드니 직관적이지 않다. DOM Tree 그려지지 않아서.
for(let i=0; i<newsList.length; i++){
  const li = document.createElement('li');
  //console.log(newList[i].title);
  li.innerHTML = newsList[i].title;
  ul.appendChild(li);
}//end of for
document.getElementById('root').appendChild(ul);