function Emp(fName, lName){ //Emp의 E는 대문자로!
  this.fName = fName; //자바와 다르게 (선언부에 선언할 수 없다 - class껍데기가 없으니까) 전역변수다.
  this.lName = lName;
}
// 화살표함수를 썼을 때와 function으로 함수를 정의할 때 this가 달라진다. -주의!
Emp.prototype.prinName = function(){
  return `${this.lName} ${this.fName}`; // 프로토타입만 변경하면 아래 정보를 수정할 수 있다.
}

Emp.prototype.see = function(pic){
  console.log(pic); // 노을사진 - 브라우저 통해 결과 확인해보자!
}

const james = new Emp('초보','나'); //생성자 함수라고 함
const king = new Emp('신입','나'); //생성자 함수라고 함

// 괄호 있을 때, 없을 때 구분 잘하기
console.log(james.prinName());
console.log(james.prinName);
james.see('노을사진');
console.log(Emp);
console.log(king.prinName());
console.log(king.prinName);
/*
  <프로토타입에 대해서>
  결국 프로토타입이라는 건 new를 통해서 만드는 생성자 함수에서 반환된 결과이다.
  그래서 fruits2는 하나의 배열 데이터, 또 다른 말로는 인스턴스라고 말하는데
  이렇게 instance에서 쓸 수 있는 별도의 속성이나 메소드를 등록하는 객체이다.
  우리가 배열 데이터를 만들 때 사용하는 array라는 객체에서 프로토타입으로 method라는
  메소드를 등록한 것 처럼..
*/