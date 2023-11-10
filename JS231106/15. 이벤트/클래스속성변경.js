const btns = document.querySelectorAll('.list li');
console.log(btns);

btns.forEach((btn, index) => {
  btn.addEventListener('click', (e) => {
    for(let item of btns){
      item.classList.remove('on');
    }
    btns[index].classList.add('on');
  })
});