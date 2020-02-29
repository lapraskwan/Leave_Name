const util = require("util");

var dbConnection = require("../dbConnection");
var connection = dbConnection.db;
var query = util.promisify(connection.query).bind(connection);

exports.getAll = async function(orderBy){
    if (orderBy === undefined) {
        var result = await query("SELECT * FROM transaction");
    }
    else {
        var result = await query(`SELECT * FROM transaction ORDER BY ${orderBy}`);
    }
    return result;
}

exports.getByAttr = async function(attr, value, orderBy){ // Also return with floor name 
    if (orderBy === undefined){
        var result = await query(`SELECT transaction.*, user.floor_name FROM transaction, user WHERE transaction.user_id = user.user_id AND transaction.${attr} = ${value}`);
    }
    else {
        var result = await query(`SELECT transaction.*, user.floor_name FROM transaction, user WHERE transaction.user_id = user.user_id AND transaction.${attr} = ${value} ORDER BY ${orderBy}`);
    }
    return result;
}

exports.getAllUsersDebt = async function(attr, value, orderBy){ // Get all debts in a floor or a team
    if (orderBy === undefined) {
        var result = await query(
            `SELECT user.user_id, user.floor_name, user.profile_pic, SUM(transaction.amount) AS total_debt
            FROM transaction, user 
            WHERE transaction.user_id = user.user_id 
            AND transaction.${attr} = ${value}
            AND transaction.status != 'Completed'
            GROUP BY user.user_id`
            );
    }
    else {
        var result = await query(
            `SELECT user.user_id, user.floor_name, user.profile_pic, SUM(transaction.amount) AS total_debt
            FROM transaction, user 
            WHERE transaction.user_id = user.user_id 
            AND transaction.${attr} = ${value}
            AND transaction.status != 'Completed'
            GROUP BY user.user_id
            ORDERED BY ${orderBy}`
            );
    }
    return result;
}

exports.getUserDebtDetail = async function(attr, value, user_id, orderBy){ // Return not completed transactions of a user
    if (orderBy === undefined) {
        var result = await query(
            `SELECT transaction.*
            FROM transaction, user 
            WHERE transaction.user_id = user.user_id 
            AND transaction.user_id = ${user_id}
            AND transaction.${attr} = ${value}
            AND transaction.status != 'Completed'`
            );
    }
    else {
        var result = await query(
            `SELECT transaction.*
            FROM transaction, user 
            WHERE transaction.user_id = user.user_id 
            AND transaction.user_id = ${user_id}
            AND transaction.${attr} = ${value}
            AND transaction.status != 'Completed'
            ORDERED BY ${orderBy}`
            );
    }
    return result;
}