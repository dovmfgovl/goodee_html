// 우리가 접근해야 할 DOM요소 선언하기
const items = document.querySelector('.items');
const input = document.querySelector('#footer_input');
const btnPlus = document.querySelector('.footer_button');

plusEvent = () => {
    // 사용자가 입력한 텍스트를 받아온다
    // 변수 선언시 : const(상수), let(변수), var(사용금지-호이스팅 이슈)
    const text = input.value;
    console.log(text);
    // 비교 시 == 두 개이면 값만 비교하고 === 세 개이면 타입도 비교함
    if(text === ''){
        input.focus(); //아무 값도 입력하지 않았을 때, 입력 칸에 focus가 가도록 설정
        return;
    }
    // 새로운 아이템을 만든다(텍스트 + 삭제버튼)
    const item = createItem(text);
    // items 컨테이너 안에 새로 만든 아이템을 추가한다
    items.appendChild(item);
    // 새로 추가된 아이템으로 스크롤링을 함
        item.scrollIntoView({ block: 'center' });
    // 인풋 값을 초기화 한다
    input.value = '';
        //커서가 미리 가 있으면 마우스 클릭하지 않고도 즉시 입력가능함
        input.focus(); //커서가 위치하게 함
        // 만일 아무것도 입력하지 않고 버튼을 누르면
        // 포커스를 input text로 옮기고 함수를 탈출함
}

createItem = (text) => {
    const itemRow = document.createElement('li'); /* DOM에서 제공하는 함수를 이용해서 태그를 만들 땐 li태그를 안 붙임*/
    itemRow.setAttribute('class','item_row'); /* 태그에 속성을 추가할 땐 setAttribute 함수를 사용할 것 */
    const item = document.createElement('div'); 
    item.setAttribute('class', 'item'); 
    const name = document.createElement('span');
    name.setAttribute('class', 'item_name');
    name.innerText = text;
    const deleteBtn = document.createElement('button');
    deleteBtn.setAttribute('class', 'item_delete');
    deleteBtn.innerHTML = '<i class="fas fa-trash-alt"></i>';
    //createItem이 호출되었을 때 화면이 먼저 완성(렌더링 == DOM TREE)되고 난
    //다음에야 버튼이 눌려질테니 파라미터의 itemRow는 createItem 함수에서
    //생성된 전부를 이미 쥐고 있다
    //html, js, css는 로컬 PC에 다운로드 된 게 실행되는 것이다.
    deleteBtn.addEventListener('click', () => {
        items.removeChild(itemRow)
    })
    const itemDivider = document.createElement('div'); //밑줄
    itemDivider.setAttribute('class', 'item_divider');
    item.appendChild(name);
    item.appendChild(deleteBtn);
    itemRow.appendChild(item);
    itemRow.appendChild(itemDivider);
    return itemRow;
}

btnPlus.addEventListener('click', () => {
    //insert here
    plusEvent();
});

//엔터쳤을 때도 동일(하나 - 함수로 묶어야 한다.)하게 처리하기 -
input.addEventListener('keypress', (e) => {
    // console.log(e.key);
    // console.log(e.key === 'Enter');
    if(e.key === 'Enter'){
        plusEvent();
    }
})