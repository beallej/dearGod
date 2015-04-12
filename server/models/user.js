var mongoose = require("mongoose");
var Schema   = mongoose.Schema;

var UserSchema = new Schema({
    UDID: String,
    currentQuestion: String
});

module.exports = mongoose.model("User", UserSchema);
