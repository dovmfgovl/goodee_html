//const 선언은 블록 범위의 상수를 선언합니다. 상수의 값은 재할당할 수 없으며 다시 선언할 수도 없습니다.
//<ajax>
//브라우저가 요청을 하면 서버에서 응답 ( html, css, js, 서버사이드 프로그램등 ) 을 한다
//Ajax 는 JS를 이용하여 비동기적으로 서버와 데이터를 주고 받는다
//화면의 일부만을 갱신해서 동적인 페이지를 만들어주는데 예를들어 페이스북, 인스타그램등의 스크롤을 떠올리면 된다
const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장 객체임
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json';
const container = document.getElementById('root');
//뉴스 comment를 담을 태그 생성하기
const content = document.createElement('div');
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json';
//open은 XMLHttpRequest 객체가 제공하는 함수로 파라미터는 3개가 필요함
//1) 전송방식 2) 요청하는 URL 3) true: 비동기, false: 동기 처리로 요청해 줌
//ajax변수는 XMLHttpRequest를 참조하는 변수명임
getData = (url) => { //url이 매개변수로 TITLE_URL이 들어올 수도, CONTENT_URL이 들어올 수도 있으니 -> 재사용성을 높이기 위해 url를 매개변수로 설정
  //arrow function으로 처리해본다. - ES6에 추가된 컨벤션
  ajax.open('GET', url, false); //어떤 url도 받는 재사용성 높이기 위해 url을 매개변수로.
  ajax.send(); //send() 호출될 때 비로소 서버측에 요청이 일어남
  return JSON.parse(ajax.response); //JSON이 Array 형식으로
};
const newsList = getData(TITLE_URL);
console.log(newsList); //서버측에서 보낸 응답을 출력해보기 - Array로 변환하여 출력해줌
const ul = document.createElement('ul'); //DOM API 가지고 태그를 만드니 직관적이지 않다. DOM Tree 그려지지 않아서.

//해시값이 변경될 때 - 인터셉트 - @id -> Array에 담긴 id값 38012345으로 변경함
//내용을 가져옴
window.addEventListener('hashchange', () => { //이벤트 감지
  const id = location.hash.substring(1); //# 떼고
  const ncontent = getData(CONTENT_URL.replace('@id', id)); //아이디만 받음
  const title = document.createElement('h1'); //('h1'), (title) - 직관적이지 않다. -> API보다 템플릿으로 만들어 재사용 높이기
  title.innerHTML = ncontent.title;
  content.appendChild(title); //<h1>제목</h1> <div>내용</div>
});

//목록을 가져옴
for (let i = 0; i < 5; i++) {
  const div = document.createElement('div'); //div 안에 내용들을 더 추가하기 위해 div를 step3부터 사용함
  div.innerHTML = `
  <li>
    <a href = "#${newsList[i].id}"> //# 뒤에 값이 없으면 빈 것이 돌아옴
      ${newsList[i].title}(🍎${newsList[i].comments_count})
    </a>
  </li>
  `;
  // ul.children(appendChild[0]); //아래와 같은 의미. ul의 첫 번째 자손(li)에 붙인다는 의미
  ul.appendChild(div.firstElementChild);
} //end of for

container.appendChild(ul);
container.appendChild(content);
