
const express = require('express');
const app = express();
const port = 3000;
const db = require("./models")
app.use(express.json())


// these  create  the tables automatically 
db.sequelize.sync()


const pastRouter = require("./routes/Posts")

app.use("/posts", pastRouter);




app.listen(port, () => {
    console.log(`Server on port  ${port}!`);
});






/*
db.sequelize.sync().then(() => {
    app.listen(port, () => {
        console.log(`Server on port  ${port}!`);
    });
});
*/




