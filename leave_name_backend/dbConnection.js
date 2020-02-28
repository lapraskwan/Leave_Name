var mysql = require("mysql");

var connection = mysql.createConnection({
    host: "localhost",
    user: process.env.mysql_username,
    password: process.env.mysql_password,
    database: process.env.mysql_database,
    charset: process.env.mysql_charset
});

connection.connect(function(err){
    if(err) throw err;
});

exports.db = connection;

