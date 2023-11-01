const ajax = new XMLHttpRequest();
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json';
const container = document.getElementById('root');
const content = document.createElement('div');
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json';
getData = (url) => {
  ajax.open('GET', url, false);
  ajax.send();
  return JSON.parse(ajax.response);
};

//뉴스목록을 가져오는 함수 구현
getNewsData = () => {
  const newsData = getData(TITLE_URL);
  const newsList = [];
  newsList.push('<ul>');
  for (let i = 0; i < 30; i++) {
    newsList.push(`
      <li>
        <a href = "#${newsData[i].id}"> 
          ${newsData[i].title}(${newsData[i].comments_count})
        </a>
      </li>
    `);
  } //end of for
  newsList.push('</ul>');
  container.innerHTML = newsList.join('');
}; //end of getNewsData()

newsDetail = () => {
  const id = location.hash.substring(1); //#389874->389874
  const ncontent = getData(CONTENT_URL.replace('@id', id));
  container.innerHTML = `
  <h1>${ncontent.title}</h1>
  <div><a href='#'>목록으로</a></div>
  `;
}; //end of newsDetail
/*
  라우터 관점에서는 글 내용에 대한 해시인지 글 목록을 보는 해시인지에 대한
  구분이 필요할 것이다.
  현재는 구분할 수 없는 상태이고 뭔가를 구분하는 구조를 만들어야 하니까
  이런 방식으로 해결해본다.
  최초 실행하면 화면에 아무것도 보이지 않는다.
  getNewsData()를 호출하는 코드가 없어서.
  그래서 라우터를 구현하여 getNewsData()를 호출할 수 있도록 한다.
  그런데 newsDetail이 hashchange에 걸려있다
  그래서 해시가 바뀌면 무조건 글 내용을 보는거야 라고 구현되어 있는 것이다.
  해시가 바뀌면 글 내용을 볼 수도 있고 글 목록을 볼 수도 있어야하니까
  그래서 이 hashchange가 일어났을 때 동작하는 함수를 기존 newsDetail이 아닌
  라우터한테 주면 라우터가 해시가 바뀔 때마다 동작하게 되고 그럼 그 라우터
  안에서 어떤 해시냐에 따라 글 목록을 보여줄 때도 있고 글 내용을 보여주기도 하는 것
*/
router = () => {
  //실제로 목록을 누르면 http://localhost:61394/# 을 갖는데
  //location.hash에 #만 있으면 빈 값을 반환함
  const routerPath = location.hash;
  // == 두 개면 값만 비교 / === 타입까지 같은지 체크(js는 3개까지 존재함)
  if (routerPath === '') {
    getNewsData(); //글 목록 보기
  } else {
    newsDetail(); //글 내용 보기
  }
};

window.addEventListener('hashchange', router); //함수가 곧 객체. 주소번지 갖고 있다. 그러므로 newsDetail()괄호 붙일 필요없다.
router();
