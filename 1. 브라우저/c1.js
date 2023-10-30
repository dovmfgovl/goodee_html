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
  });
});
