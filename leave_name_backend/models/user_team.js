const util = require("util");

var dbConnection = require("../dbConnection");
var connection = dbConnection.db;
var query = util.promisify(connection.query).bind(connection);

exports.getAll = async function(orderBy){
    if (orderBy === undefined) {
        var result = await query(
            `SELECT * 
            FROM user_team, user, team 
            WHERE user_team.user_id = user.user_id
            AND user_team.team_id = team.team_id`
            );
    }
    else {
        var result = await query(
            `SELECT * 
            FROM user_team, user, team 
            WHERE user_team.user_id = user.user_id
            AND user_team.team_id = team.team_id
            ORDER BY ${orderBy}`
            );
    }
    return result;
}

exports.getTeamsOfUser = async function(user_id, orderBy){
    if (orderBy === undefined){
        var result = await query(
            `SELECT team.* 
            FROM user_team, team
            WHERE user_team.user_id = ${user_id}
            AND user_team.team_id = team.team_id`
            );
    }
    else {
        var result = await query(
            `SELECT team.* 
            FROM user_team, team
            WHERE user_team.user_id = ${user_id}
            AND user_team.team_id = team.team_id
            ORDER BY ${orderBy}`
            );
    }
    return result;
}

exports.getUsersInTeam = async function(team_id, orderBy){
    if (orderBy === undefined){
        var result = await query(
            `SELECT user.* 
            FROM user_team, user
            WHERE user_team.team_id = ${team_id}
            AND user_team.user_id = user.user_id`
            );
    }
    else {
        var result = await query(
            `SELECT team.* 
            FROM user_team, team
            WHERE user_team.user_id = ${user_id}
            AND user_team.team_id = team.team_id
            ORDER BY ${orderBy}`
            );
    }
    return result;
}