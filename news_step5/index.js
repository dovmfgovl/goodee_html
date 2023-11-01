const ajax = new XMLHttpRequest();
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json';
const container = document.getElementById('root');
const content = document.createElement('div');
//@id로 된 부분을 JSON 포맷파일에서 id값을 읽어와 치환해야 함
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json';

getData = (url) => {
  ajax.open('GET', url, false);
  ajax.send();
  return JSON.parse(ajax.response);
};

const newsList = getData(TITLE_URL);
console.log(newsList);
const ul = document.createElement('ul');

window.addEventListener('hashchange', (event) => {
  //location.hash -> #33899902 //내장객체 location의 속성인 hash
  const id = location.hash.substring(1);
  const ncontent = getData(CONTENT_URL.replace('@id', id)); //@id로 된 부분을 JSON 포맷파일에서 id값을 읽어와 치환하는 replace

  container.innerHTML = `
  <h1>${ncontent.title}</h1>
  <div><a href='#'>목록으로</a></div>
  `;
});
//배열 선언하기 - 뉴스목록을 배열에 담아서 한 번에 root안에 집어넣기
//append로 추가하지 말고 새로고침이 된 것 처럼 덮어쓴다.
const newsPage = []; //배열 선언
newsPage.push('<ul>'); //열린 태그가 있다면 닫힌 태그도 필요 //ul태그는 한번만 실행하면 됨. 따라서 for문 밖에서
for (let i = 0; i < 10; i++) {
  //# 붙여야 hashchange 이벤트 발동됨
  newsPage.push(`
    <li>
      <a href = '#${newsList[i].id}'> 
        ${newsList[i].title}(${newsList[i].comments_count})
      </a>
    </li>
  `);
} //end of for
newsPage.push('</ul>'); //닫힌 태그
/*
  join : 배열 자체를 하나의 문자열로 합치는 기능을 배열이 제공
  join 함수를 그대로 호출하면 배열 요소에 있는 요소들을 하나의 문자열로 합쳐주는데
  그것들을 콤마라고 하는 문자열로 구분자를 넣어준다 - 디폴트가 콤마
  그런데 여기서는 필요 없어서 구분자 역할을 빈문자열로 대신 함.
*/
container.innerHTML = newsPage.join(''); //하나로 합쳐주는 메소드 join

/*
  DOM API를 사용하여 페이지를 그렸더니 직관적(DOM TREE)이지 않아서
  유지보수하는데 불편할 것 같다.
  이것을 개선하고 싶은데 그렇게 하려면 오히려 DOM API를 사용하지 않아야겠다.
  대신 문자열을 이용해서 태그를 이어 붙이면 코드 양은 늘어나지만
  오히려 복잡도는 낮출 수도 있지 않나?
  전체적인 구조를 좀 바꿔볼까?
  createElement, appendChild 가능한 다 걷어내자.
*/
