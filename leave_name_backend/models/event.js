const util = require("util");

var dbConnection = require("../dbConnection");
var connection = dbConnection.db;
var query = util.promisify(connection.query).bind(connection);

exports.getAll = async function (orderBy) {
    if (orderBy === undefined) {
        var result = await query(
            `SELECT * 
            FROM event
            LEFT OUTER JOIN floor_event ON event.event_id = floor_event.event_id
            LEFT OUTER JOIN team_event ON event.event_id = team_event.event_id
            LEFT OUTER JOIN interhall_event ON event.event_id = interhall_event.event_id`
        );
    }
    else {
        var result = await query(
            `SELECT * 
            FROM event
            LEFT OUTER JOIN floor_event ON event.event_id = floor_event.event_id
            LEFT OUTER JOIN team_event ON event.event_id = team_event.event_id
            LEFT OUTER JOIN interhall_event ON event.event_id = interhall_event.event_id 
            ORDER BY ${orderBy}`
        );
    }
    return result;
}

exports.getByAttr = async function (attr, value, orderBy) {
    if (orderBy === undefined) {
        var result = await query(
            `SELECT event.*, floor_event.floor, team_event.team_id, interhall_event.stage, interhall_event.opponent, interhall_event.team
            FROM event
            LEFT OUTER JOIN floor_event ON event.event_id = floor_event.event_id
            LEFT OUTER JOIN team_event ON event.event_id = team_event.event_id
            LEFT OUTER JOIN interhall_event ON event.event_id = interhall_event.event_id 
            WHERE ${attr} = ${value}`
        );
    }
    else {
        var result = await query(
            `SELECT event.*, floor_event.floor, team_event.team_id, interhall_event.stage, interhall_event.opponent, interhall_event.team
            FROM event
            LEFT OUTER JOIN floor_event ON event.event_id = floor_event.event_id
            LEFT OUTER JOIN team_event ON event.event_id = team_event.event_id
            LEFT OUTER JOIN interhall_event ON event.event_id = interhall_event.event_id 
            WHERE ${attr} = ${value} 
            ORDER BY ${orderBy}`
        );
    }
    return result;
}

exports.getByUser = async function (user_id, orderBy) {
    // 1. Get the array of team_id that user is in
    // 2. Get thhe floor of the user
    // 3. Get the hall events and interhall events
    if (orderBy === undefined) {
        var result = await query(
            `SELECT event.*, floor_event.floor, team_event.team_id, interhall_event.stage, interhall_event.opponent, interhall_event.team
            FROM event
            LEFT OUTER JOIN floor_event ON event.event_id = floor_event.event_id
            LEFT OUTER JOIN team_event ON event.event_id = team_event.event_id
            LEFT OUTER JOIN user_in_team ON user_in_team.team_id = team_event.team_id
            LEFT OUTER JOIN user ON floor_event.floor = user.floor
            LEFT OUTER JOIN interhall_event ON event.event_id = interhall_event.event_id
            WHERE event.type = 'interhall'
            OR event.type = 'hall'
            OR user.user_id = ${user_id}
            OR user_in_team.user_id = ${user_id}`
        );
    }
    else {
        var result = await query(
            `SELECT event.*, floor_event.floor, team_event.team_id, interhall_event.stage, interhall_event.opponent, interhall_event.team
            FROM event
            LEFT OUTER JOIN floor_event ON event.event_id = floor_event.event_id
            LEFT OUTER JOIN team_event ON event.event_id = team_event.event_id
            LEFT OUTER JOIN user_in_team ON user_in_team.team_id = team_event.team_id
            LEFT OUTER JOIN user ON floor_event.floor = user.floor
            LEFT OUTER JOIN interhall_event ON event.event_id = interhall_event.event_id
            WHERE event.type = 'interhall'
            OR event.type = 'hall'
            OR user.user_id = ${user_id}
            OR user_in_team.user_id = ${user_id}
            ORDER BY ${orderBy}`
        );
    }
    return result;
}

