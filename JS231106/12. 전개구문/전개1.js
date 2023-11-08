//전개연산자
// spread operator를 이용해서 배열을 복사하면 깊은 복사이다.

//배열 뿐만 아니라 객체 간에도 사용할 수 있다.
let dept = {
  deptno : 10,
  dname : '총무부',
  loc : '부산'
}

let emp = {
  empno : 7566,
  ename : '강감찬'
}

let newObject = { ...dept, ...emp}
console.log(newObject);

//밖은 List 안은 Map 같은 구조. 밖은 배열 안은 객체
let depts = [
  {deptno : 10, dname : '총무부', loc: '부산'},
  {deptno : 20, dname : '개발부', loc: '서울'},
  {deptno : 30, dname : '인사부', loc: '인천'}
]

let depts2 = [...depts, { deptno : 40, dname : '운영부', loc : '제주'}];
console.log(depts2);
let depts3 = [...depts2, { deptno : 50 }];
console.log(depts3);
//forEach - ES5임
depts.forEach(dept => console.log(dept))
depts.forEach((dept, index) => {
  if(index ===1){
    console.log(dept);
    console.log(dept.dname);
    console.log(dept['loc']);
  }
}) //end of forEach
//map - ES6임
depts.map((dept, index, arr) => {
  console.log(dept);
  console.log(index);
  console.log(arr);
})

//배열
const names = ["나신입", "나일등", "김자바"];
const names2 = [...names, "나초보"];
const names3 = ["나신입", "나일등", "김자바"];
console.log(names2);
console.log(names);
console.log(names == names2);
console.log(names === names2); //타입까지도 일치하니?
console.log(names == names3);
console.log(names === names3);