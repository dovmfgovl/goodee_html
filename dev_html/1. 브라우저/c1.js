const vertical = document.querySelector('.vertical');
const horizontal = document.querySelector('.horizontal');
const target = document.querySelector('.target');
const label = document.querySelector('.label');
//const 상수 선언시, let 변하는 값을 사용할 때
//var - 호이스팅 이슈로 사용하면 안 됨
addEventListener('load', () => {
  console.log('test');
  const domRect = target.getBoundingClientRect();
  const twidth = domRect.width;
  const theight = domRect.height;
  console.log(`${twidth}, ${theight}`); //`` 자주 사용함
  document.addEventListener('mousemove', (event) => {
    const x = event.clientX;
    const y = event.clientY;
    console.log(`$(event.clientX), $(event.clientY)`);
    //문제제기 - 좌표 값이 출력되는 건 확인했지만 가로와 세로 선이 그대로이다. 해결해보자.
    vertical.style.left = `${x}px`;
    horizontal.style.top = `${y}px`;
    target.style.left = `${x}px`;
    target.style.top = `${y}px`;
    label.style.left = `${x}px`;
    label.style.top = `${y}px`;
    label.innerHTML = `(${x}px, ${y}px)`;
    //TextNode는 NodeName은 없는데 NodeValue는 있다.
    //label.innerHTML = `(100px, 100px)`;
  });
});
