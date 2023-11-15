function Emp(fName, lName){
  this.fName = fName; //자바와 다르게 (선언부에 선언할 수 없다 - class껍데기가 없으니까) 전역변수다.
  this.lName = lName;
}
// 화살표함수를 썼을 때와 function으로 함수를 정의할 때 this가 달라진다. -주의!
Emp.prototype.prinName = function(){
  return `${this.lName} ${this.fName}`; // 프로토타입만 변경하면 아래 정보를 수정할 수 있다.
}

const james = new Emp('초보','나'); //생성자 함수라고 함
const king = new Emp('신입','나'); //생성자 함수라고 함

// 괄호 있을 때, 없을 때 구분 잘하기
console.log(james.prinName());
console.log(james.prinName);
console.log(king.prinName());
console.log(king.prinName);