const express = require('express')
const mongose = require('mongoose')
var app = express()
var Data = require('./nodeSchema')

mongose.connect('mongodb://localhost/newDB')
mongose.connection.once("open",() => { 
    console.log("Connected to DB!")
}).on("error",(error) => { 
    console.log("Failed to connect with error" + console.error())
})
 

// Create a note POST
 
app.post("/create",(req,res) => {

 var note = new Data({
     note:req.get("note"),
     title:req.get("title"),
     date:req.get("date"),
 })

 note.save().then(() => {
    if (note.isNew == false) { 
        // print("Data is saved")
        res.send("saved data")
    }
    else { 
        // print("Data is not saved")
        console.log("Some error occured please try again")
    }
 })
})

// Delete a note  POST

app.post("/delete",(req,res) => {
    Data.findOneAndRemove({
        _id:req.get("id")
    },(err) => {
        res.send("Failed with error " + err)
    })
})

// Update a note POST


app.post("/update",(req,res) => {
    Data.findOneAndUpdate({
        _id:req.get("id")
    },{
        note:req.get("note"),
        title:req.get("title"),
        date:req.get("date")
    }
    ,(err) => {
        res.send("Failed with error " + err)
    })
})

// Fetch a note GET

app.get("/fetch",(req,res) => {
Data.find({}).then((DBItems) => { 
res.send(DBItems)
})
})

var server = app.listen(8081,"192.168.1.101",()=>{
    console.log("Server is running")
}) .on("error",(error) => { 
    console.log("Failed to connect with error " + error)
})
 // any device which is connected to your network can access this application

