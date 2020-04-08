const express = require('express');
const app = express();
const route = require('./routes');
app.use('/API', route);
const port = process.env.PORT || 8000;
app.listen(port, function(){
    console.log("Running API on Port " + port);
});

