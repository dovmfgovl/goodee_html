/*
웹 애플리케이션을 위한 기본적인 설정을 가지고 있다
모듈을 로딩하고 템플릿 엔진을 설정하여 라우터 설정함
파일 상단에는 사용할 모듈을 로딩하는 코드가 작성됨
외부 모듈을 해당 파일에서 사용하고 싶다면 require() 함수를 호출해야 함
*/
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
// 라우트 코드를 로딩하는 코드임. require()함수를 사용하며
//로딩한 라우트 함수들을 지정된 변수로 사용할 수 있게 해 줌
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
//express 객체를 app변수로 선언함
var app = express();

// view engine setup
//익스프레스에서 사용할 템플릿 엔진을 설정하는 코드임
//__dirname(별다른 의미가 있는 것은 아님. 없을 문자를 적은 것)은 현재 디렉토리를 의미하며 path.join() 함수는 경로를 연결하는 기능을 함
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs'); //템플릿 엔진의 종류
//파라미터에 지정된 인자를 실행하는 함수임
//여기서는 각각의 모듈을 사용하도록 설정함
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
//라우트를 설정하는 코드임. 여기서 라우트는 url경로의 뒷부분을 의미함
//'/'와 관련된 라우트는 routes 폴더의 index 파일에 설정된 라우트 함수를 통해 처리됨
app.use('/', indexRouter);
//'/users'와 관련된 라우트는 users 파일에 작성된 라우트 함수를 통해 처리됨 - MyPage, 대시보드, 장바구니
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
