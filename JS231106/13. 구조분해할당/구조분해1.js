//구조분해 할당
//1. 배열
const colors = ['red', 'green', 'blue'];
//ES5
const color1 = colors[0];
const color2 = colors[1];
const color3 = colors[2];
//ES6 - 구조분해할당
const [c1, c2, c3] = colors;
console.log(c1+c2,c3); //redgreen blue

//2. 객체
const dept = {
  deptno: 10,
  dname: '개발부',
  loc: '서울'
}

const {deptno, dname, loc} = dept
//ES5
console.log(dept.deptno); //10
console.log(dept['dname']); //개발부
console.log(deptno); //10
console.log(dname); //개발부
console.log(loc); //서울