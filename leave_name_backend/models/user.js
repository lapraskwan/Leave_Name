const util = require("util");

var dbConnection = require("../dbConnection");
var connection = dbConnection.db;
var query = util.promisify(connection.query).bind(connection);

exports.getAll = async function(orderBy){
    if (orderBy === undefined) {
        var result = await query("SELECT * FROM user");
    }
    else {
        var result = await query(`SELECT * FROM user ORDER BY ${orderBy}`);
    }
    return result;
}

exports.getByAttr = async function(attr, value, orderBy){
    if (orderBy === undefined){
        var result = await query(`SELECT * FROM user WHERE ${attr} = ${value}`);
    }
    else {
        var result = await query(`SELECT * FROM user WHERE ${attr} = ${value} ORDER BY ${orderBy}`);
    }
    return result;
}