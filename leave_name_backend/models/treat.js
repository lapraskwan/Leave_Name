const util = require("util");

var dbConnection = require("../dbConnection");
var connection = dbConnection.db;
var query = util.promisify(connection.query).bind(connection);

exports.getAll = async function(orderBy){
    if (orderBy === undefined) {
        var result = await query("SELECT * FROM treat");
    }
    else {
        var result = await query(`SELECT * FROM treat ORDER BY ${orderBy}`);
    }
    return result;
}

exports.getByAttr = async function(attr, value, orderBy){ // Also return with floor name 
    if (orderBy === undefined){
        var result = await query(`SELECT treat.*, user.floor_name FROM treat, user WHERE treat.user_id = user.user_id AND treat.${attr} = ${value}`);
    }
    else {
        var result = await query(`SELECT treat.*, user.floor_name FROM treat, user WHERE treat.user_id = user.user_id AND treat.${attr} = ${value} ORDER BY ${orderBy}`);
    }
    return result;
}