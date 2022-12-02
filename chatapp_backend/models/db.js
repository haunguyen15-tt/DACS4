//local
// require('./user.js');
// require('./chat.js');
// require('./schedule.js');
// require('./call.js');
// require('./otp.js');

const mongoose = require('mongoose');

mongoose.connect(
  'mongodb+srv://demons1502:rJYV27YtF9wRm0dQ@cluster0.axsjz84.mongodb.net/?retryWrites=true&w=majority',
  {
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false,
    useUnifiedTopology: true,
  },
  (err) => {
    if (!err) {
      console.log('Connected successfully to Mongodb server 123');
    } else {
      console.log('Error : ' + err);
    }
  }
);
