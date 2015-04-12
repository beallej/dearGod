var Question = require("./models/question");
var User     = require("./models/user");
var q        = require("q");

var delegate = function(question, users, pusher) {
    var rand = Math.floor(Math.random() * users.length);
    var chosenUser = users[rand];

    // don't let same user be asked twice
    question.rejectedUsers.push(chosenUser._id);
    users.splice(users.indexOf(chosenUser), 1);

    // actually send to user ...
    console.log("Sending to user...");
    User.findById(chosenUser._id, function (err, user) {

        // figure out if we can set the question
        if (user.currentQuestion == null) {
            user.currentQuestion = question;
            userQuestionSet =  true;
        } else {
            userQuestionSet = false;
        }

        // redelegate if the user already has a question
        if (!(userQuestionSet)) {
            delegate(question, users, pusher);
        }

        // push question to user
        pusher.trigger(chosenUser._id.toString(), "question_sent", {
            "question" : question.q
        });

        // after 60 seconds, send to someone else if chosenUser hasn't answered
        setTimeout(function() {
            Question.findById(question._id, function(err, q) {
                if (q.a != null) {
                    return;
                } else if (users.length > 0) {
                    User.findById(chosenUser._id, function(err, user) {
                        user.currentQuestion == null;
                    });

                    delegate(question, users, pusher);
                } else {
                    console.log("all users asked");
                    return;
                }
            });
        }, 5000);

    });

}

module.exports.delegate = delegate;
