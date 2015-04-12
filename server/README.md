Usage
================

| URL                            | Method |    Params   | JSON                                    | Function                                                       | Returns              |
|--------------------------------|--------|:-----------:|-----------------------------------------|----------------------------------------------------------------|----------------------|
| /api/users/                    | GET    |             |                                         | adds a new user, assigns ID                                    | { id : user_id }     |
| /api/questions                 | GET    |             |                                         | gets the most recent 50 answered questions                     | [question objects]   |
| /api/questions/my/:userid      | GET    |    userid   |                                         | gets the most recent 10 answered questions that I asked        | [question objects]   |
| /api/questions                 | POST   |             | { userId : userId, question: question } | adds a new question                                            | { id : question_id } |
| /api/questions/:question_id    | GET    | question_id |                                         | gets the question with the given id                            | question object      |
| /api/questions/:question_id    | PUT    | question_id | { answer: answer }                      | adds an answer to a question                                   |                      |
| /api/questions/answer/:user_id | GET    | user_id     |                                         | gets a question for a user - unassigns if too much time passes | question object      |
| /api/users/:user_id            | GET    | user_id     |                                         | gets user with an id                                           | user object          |

- user object: { _id : (user id) }
- question object: { _id : (String - user id), q : (String - question), a : (String - answer) }
