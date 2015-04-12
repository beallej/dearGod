var mongoose = require("mongoose");
var Schema   = mongoose.Schema;

var QuestionSchema = new Schema({
    q: String,
    a: String,
    rejectCount: Number,
    answered: Boolean,
    askerId: String
});

module.exports = mongoose.model("Question", QuestionSchema);
