const person = {
  firstName: '초보',
  lastName: '나',
  printName: function(){
    return `${this.firstName} ${this.lastName}`
  }
}
const student = {
  firstName: '신입',
  lastName: '나'
}

console.log(person.printName()); //이름을 보고싶으니 printName()
//console.log(student.printName());
console.log(person.printName);
console.log(person.printName.call(student)); //함수도 객체이기 때문에(일급함수,일급객체) printName()이 아닌 printName으로