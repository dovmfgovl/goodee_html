const a = document.querySelector('a');

console.dir(a);

a.onclick = () => {
  console.log('링크클릭');
}

a.onclick = () => {
  console.log('링크클릭 다시');
}

a.addEventListener('click', () =>{
  console.log('you click');
})

a.addEventListener('click', () =>{
  console.log('you click again');
})