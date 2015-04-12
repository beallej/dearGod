// server.js

// packages
var express    = require("express"),
    app        = express(),
    bodyParser = require("body-parser"),
    fs         = require('fs');


// mongo setup
var mongoose   = require("mongoose");

// prod db
mongoose.connect("mongodb://lbiester:HackISU2015@ds061741.mongolab.com:61741/deargod");

// local db
// mongoose.connect("mongodb://localhost:27017/deargod");


var Question = require("./models/question");
var User     = require("./models/user");

// silly views for God's Words
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));


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
        question.askerId = req.body.userId;

        // save qustion
        question.save(function(err, question) {
            res.json({ id : question._id.toString() });
        })
    })

    // get last 50 answered questions
    .get(function(req, res) {
        Question.find({ $query : { a: {$ne: null}}, $orderby: { dateAnswered : -1 }},
            {}, { limit: 50 }, function(err, questions) {
            if (err) {
                res.send(err);
            }
            res.json(questions);
        })
    })


// send back the 10 most recent questions I have asked
router.route("/questions/my/:user_id")

    .get(function(req, res){
        // most recent 10 questions that have been answered that I asked...yeesh
        Question.find({ $query : { askerId: req.params.user_id, a: {$ne: null}},
            $orderby: { dateAnswered : -1 }}, {}, { limit: 10 }, function(err, questions) {
            if (err) {
                res.send(err);
            } else {
                res.send(questions);
            }
        });
    });

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
            if (question == null) {
                res.send(err);
            }

            var answer = req.body.answer;
            question.a = answer;
            question.dateAnswered = new Date();

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
        Question.find( {a: null, rejectCount: { $lt: 6 }, $or: [ { currentlyAnswering: null },
            { dateAnswered: {$lt : new Date(new Date().getTime() - 60000) } } ] }, function(err, questions) {
            if (err) {
                res.send(err);
            } else {
                var rand = Math.floor(Math.random() * questions.length);
                var chosenQuestion = questions[rand];

                if (chosenQuestion == null) {
                    res.json({ });
                    return;
                }

                // set currently answering
                chosenQuestion.currentlyAnswering = req.params.id;
                chosenQuestion.dateAnswered = new Date();
                chosenQuestion.rejectCount += 1;
                chosenQuestion.save();

                res.json(chosenQuestion);
            }
        });
    });


router.route("/users/")

    // add new user
    .get(function(req, res) {
        var user = new User();

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

router.route("/God")

    // get the true words of God
    .get(function(req, res) {
        fs.readFile("bible.txt", "utf-8", function(err, data) {
            if (err) {
                res.send(err);
            } else {
                var lines = data.split(/\r?\n/);
                var TheChosenLine = getGodLine(lines);
                res.send({ "words" : TheChosenLine });
            }
        });
    });

app.get("/", function(req, res) {
    fs.readFile("bible.txt", "utf-8", function(err, data) {
        if (err) {
            res.send(err);
        } else {
            var lines = data.split(/\r?\n/);
            var TheChosenLine = getGodLine(lines);
            res.render("index", { "words" : TheChosenLine });
        }
    });
})

var getGodLine = function(lines) {
    var rand = Math.floor(Math.random() * lines.length);
    var TheChosenLine = lines[rand];
    return TheChosenLine.replace("\t", "    ");
}

app.use("/api", router);

// start server
app.listen(port);
console.log("your port: " + port);
