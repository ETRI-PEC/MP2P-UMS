var express = require('express');
var app = express();
var port = 7000;
var bodyParser = require('body-parser');
var session = require('express-session');
var fs = require("fs");
/*
var mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit: 3,
    host: 'localhost',
    user: 'ums',
    database: 'UMSdb',
    password: 'ums'
});
*/

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);


var server = app.listen(port, function() {
    console.log("Server is running on " + port);
})

app.use(express.static('public'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());


var router = require('./router/router')(app, fs);
