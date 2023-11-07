import {DeptVO} from './deptvo.js';

const dvo = new DeptVO(30, '개발부', '서울');

console.log(dvo);
console.log(dvo.getDeptno);
console.log(dvo.deptno); // 캡슐화는 객체지향에만 있기 때문에 deptno라고만 호출해도 가능 
console.log(dvo.getDname);
console.log(dvo.getLoc);