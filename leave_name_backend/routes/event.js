const express = require("express");
const router = express.Router();
var event = require("../models/event");

// Get all events
router.get("/getAll", (req, res) => {
    event.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get events filtered by attribute
router.get("/getByAttr", (req, res) => {
    event.getByAttr(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

// Get events of a user
router.get("/getByUser/:user_id", (req, res) => {
    event.getByUser(req.params.user_id, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

module.exports = router;