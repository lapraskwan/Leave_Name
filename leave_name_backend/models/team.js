const util = require("util");

var dbConnection = require("../dbConnection");
var connection = dbConnection.db;
var query = util.promisify(connection.query).bind(connection);

exports.getAll = async function(orderBy){
    if (orderBy === undefined) {
        var result = await query("SELECT * FROM team");
    }
    else {
        var result = await query(`SELECT * FROM user_in_team ORDER BY ${orderBy}`);
    }
    return result;
}

exports.getByAttr = async function(attr, value, orderBy){
    if (orderBy === undefined){
        var result = await query(`SELECT * FROM team WHERE ${attr} = ${value}`);
    }
    else {
        var result = await query(`SELECT * FROM team WHERE ${attr} = ${value} ORDER BY ${orderBy}`);
    }
    return result;
}

exports.getAllUserTeam = async function(orderBy){
    if (orderBy === undefined) {
        var result = await query(
            `SELECT * 
            FROM user_in_team, user, team 
            WHERE user_in_team.user_id = user.user_id
            AND user_in_team.team_id = team.team_id`
            );
    }
    else {
        var result = await query(
            `SELECT * 
            FROM user_in_team, user, team 
            WHERE user_in_team.user_id = user.user_id
            AND user_in_team.team_id = team.team_id
            ORDER BY ${orderBy}`
            );
    }
    return result;
}

exports.getTeamsOfUser = async function(user_id, orderBy){
    if (orderBy === undefined){
        var result = await query(
            `SELECT team.* 
            FROM user_in_team, team
            WHERE user_in_team.user_id = ${user_id}
            AND user_in_team.team_id = team.team_id`
            );
    }
    else {
        var result = await query(
            `SELECT team.* 
            FROM user_in_team, team
            WHERE user_in_team.user_id = ${user_id}
            AND user_in_team.team_id = team.team_id
            ORDER BY ${orderBy}`
            );
    }
    return result;
}

exports.getTeamsNotJoinedByUser = async function(user_id, orderBy){
    if (orderBy === undefined){
        var result = await query(
            `SELECT team.* 
            FROM user_in_team, team
            WHERE user_in_team.team_id = team.team_id
            AND user_in_team.team_id NOT IN (SELECT DISTINCT user_in_team.team_id
                                             FROM user_in_team
                                             WHERE user_in_team.user_id = ${user_id})`
            );
    }
    else {
        var result = await query(
            `SELECT team.* 
            FROM user_in_team, team
            WHERE user_in_team.team_id = team.team_id
            AND user_in_team.team_id NOT IN (SELECT DISTINCT user_in_team.team_id
                                             FROM user_in_team
                                             WHERE user_in_team.user_id = ${user_id})
            ORDER BY ${orderBy}`
            );
    }
    return result;
}

exports.getUsersInTeam = async function(team_id, orderBy){
    if (orderBy === undefined){
        var result = await query(
            `SELECT user.* 
            FROM user_in_team, user
            WHERE user_in_team.team_id = ${team_id}
            AND user_in_team.user_id = user.user_id`
            );
    }
    else {
        var result = await query(
            `SELECT team.* 
            FROM user_in_team, team
            WHERE user_in_team.user_id = ${user_id}
            AND user_in_team.team_id = team.team_id
            ORDER BY ${orderBy}`
            );
    }
    return result;
}