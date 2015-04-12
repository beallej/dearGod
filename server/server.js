// server.js

// packages
var express    = require("express"),
    app        = express(),
    bodyParser = require("body-parser");


// mongo setup
var mongoose   = require("mongoose");

// prod db
// mongoose.connect("mongodb://lbiester:HackISU2015@ds061741.mongolab.com:61741/deargod");

// local db
mongoose.connect("mongodb://localhost:27017/deargod");


var Question = require("./models/question");
var User     = require("./models/user");


// use bodyParser
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


// port
var port = process.env.PORT || 8080;

// routes
var router = express.Router();

router.use(function(req, res, next) {
    // do logging
    next(); // make sure we go to the next routes and don't stop here
});


router.get("/", function(req, res) {
    res.send({ message: "got to test route!"});
});

router.route("/questions")

    // add new question
    .post(function(req, res) {
        var question = new Question();
        question.q = req.body.question;
        question.rejectCount = 0;

        // save qustion
        question.save(function(err, question) {
            res.json({ id : question._id.toString() });
        })
    })

    // get questions
    .get(function(req, res) {
        Question.find(function(err, questions) {
            if (err) {
                res.send(err);
            } else {
                res.json(questions);
            }
        })
    })

router.route("/questions/:question_id")

    // get question with id :question_id
    .get(function(req, res) {
        Question.findById(req.params.question_id, function(err, question) {
            if (err) {
                res.send(err);
            } else {
                res.json(question);
            }
        });
    })

    // update question with new answer
    .put(function(req, res) {
        Question.findById(req.params.question_id, function(err, question) {
            var answer = req.body.answer;
            question.a = answer;

            // save question
            question.save(function(err) {
                if (err) {
                    res.send(err);
                } else {
                    res.json({ message : "Answer added"});
                }
            });
        });
    })


// :id is user id
router.route("/questions/answer/:id")

    // sends a question to a user
    .get(function(req, res) {
        Question.find( { rejectCount: { $lt: 6 }, currentlyAnswering: null }, function(err, questions) {
            if (err) {
                res.send(err);
            } else {
                var rand = Math.floor(Math.random() * questions.length);
                var chosenQuestion = questions[rand];

                // set currently answering
                chosenQuestion.currentlyAnswering = req.params.id;
                chosenQuestion.save();

                setTimeout(function() {
                    chosenQuestion.rejectCount += 1;
                    chosenQuestion.currentlyAnswering = null;
                    chosenQuestion.save();
                }, 60000);
                res.json(chosenQuestion);
            }
        });
    });


router.route("/users/")

    // add new user with UUID :UUID and ip :ip
    .post(function(req, res) {
        var user = new User();
        user.ip = req.body.ip;

        user.save(function(err, user) {
            if (err) {
                res.send(err);
            } else {
                res.json({ id : user._id.toString()});
            }
        })
    })

router.route("/users/:id")

    // get user with id :id
    .get(function(req, res) {
        User.findById(req.params.id, function(err, user) {
            if (err) {
                res.send(err);
            } else {
                res.json(user);
            }
        });
    })

app.use("/api", router);

// start server
app.listen(port);
console.log("your port: " + port);
