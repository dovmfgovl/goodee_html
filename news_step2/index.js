//XMLHttpRequest는 브라우저가 제공하는 비동기통신객체이다.
//이 객체를 생성하면 open(), send() 호출할 수 있다.
//const 선언은 블록 범위의 상수를 선언. 상수의 값은 재할당할 수 없으며 다시 선언할 수 없다.
const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장 객체임
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json'; //뉴스 목록 가져오는
const container = document.getElementById('root');
//뉴스 comment를 담을 태그 생성하기
const content = document.createElement('div');
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json'; //뉴스 댓글 가져오는
//open은 XMLHttpRequest 객체가 제공하는 함수로 파라미터는 3개가 필요함
//1) 전송방식: 클라이언트에서 -> 서버 측에 요청할 때 2) 요청하는 URL 3) true: 비동기, false: 동기 처리로 요청해 줌
//동기적으로 처리한다면 굳이 XMLHttpRequest 사용할 필요 없다.
//ajax변수는 XMLHttpRequest를 참조하는 변수명임
ajax.open('GET', TITLE_URL, false);
ajax.send(); //send() 호출될 때 비로소 서버측에 요청이 일어남
//위에서 요청했을 때 서버측의 응답을 받아오는 속성이 response임
//response 속성값도 XMLHttpRequest 객체 제공함
const newsList = JSON.parse(ajax.response);
console.log(newsList); //서버측에서 보낸 응답을 출력해보기 - Array로 변환하여 출력해줌
const ul = document.createElement('ul'); //DOM API 가지고 태그를 만드니 직관적이지 않다. DOM Tree 그려지지 않아서. //생성할 태그이름을 정함

//해시값이 변경될 때 - 인터셉트 - @id -> Array에 담긴 id값 38012345으로 변경함
/*window.*/ addEventListener('hashchange', (event) => {
  console.log('해시변경되었나???');
  console.log(location.hash); //#38019991 -> #38019991.substring(0) -> #38019991
  const id = location.hash.substring(1); //location도 내장객체 - 인터페이스로 객체가 연결된 장소(url)를 표현함 //substring 파라미터에 1을 주어 #을 제외시킴
  console.log(id);
  ajax.open('GET', CONTENT_URL.replace('@id', id), false);
  ajax.send();

  const ncontent = JSON.parse(ajax.response);
  const title = document.createElement('h1');
  title.innerHTML = ncontent.title;
  //파라미터 자리에 변수가 왔다 - 싱글 쿼테이션''은 없다
  //파라미터에 변수를 사용하면 대응하는 객체는 따로 존재함(title 자리에 document.createElement('h1')이 온 것이나 마찬가지)
  //기존에 태그 하위태그로 추가하는 함수
  content.appendChild(title); //<div><h1>제목{텍스트노드: 태그이름은 없고 값은 있다.}</h1></div>
  console.log(title);
  console.log(ncontent);
});

for (let i = 0; i < 5; i++) {
  const li = document.createElement('li'); //<li>
  const a = document.createElement('a'); //<a>
  a.href = `#${newsList[i].id}`; //<a href=''>여기 들어갈 정보가 현재 없다</a>
  console.log(a.href);
  //console.log(newList[i].title);
  //innerHTML을 통해서 a태그 내부에 택스트노드를 결정해준다.
  a.innerHTML = `${newsList[i].title}(🚨${newsList[i].comments_count})`;
  li.appendChild(a); //<li>에 <a>를 붙여달라는 의미
  ul.appendChild(li); //<ul>태그에 <li> 붙여달라는 의미
} //end of for

container.appendChild(ul); //document.getElementById('root').ul -> <div id = 'root'>인데 <ul>태그 붙여달라는 의미
container.appendChild(content); //appendChild는 기존에 있는 노드에 추가(덮어쓰기X, 추가)
