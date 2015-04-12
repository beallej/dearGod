var mongoose = require("mongoose");
var Schema   = mongoose.Schema;

var QuestionSchema = new Schema({
    q: String,
    a: String,
    rejectCount: Number,
    currentlyAnswering: String,
    askerId: String
});

module.exports = mongoose.model("Question", QuestionSchema);
