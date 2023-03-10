
const express = require('express');
const path = require('path');

if (process.env.JAWSDB_URL) {
    connection = mysql.createConnection(process.env.JAWSDB_URL);
} else {
    require('dotenv').config();
}

const app = express();

// Middleware
app.use( express.json() );
app.use( express.urlencoded({ extended: false }) );


// Routes
app.use('/api', require("./Routes/user.routes"));
app.use('/api', require("./Routes/auth.routes"));
app.use('/api', require("./Routes/product.routes"));
app.use('/api', require("./Routes/category.routes"));
app.use('/api', require("./Routes/keranjang.routes"));
app.use('/api', require("./Routes/pembayaran.routes"));


// This folder will be Public
app.use( express.static( path.join( __dirname, 'Uploads/Profile') ));
app.use( express.static( path.join( __dirname, 'Uploads/Home' )));
app.use( express.static( path.join( __dirname, 'Uploads/Products' )));
app.use( express.static( path.join( __dirname, 'Uploads/Categories' )));
app.use( express.static( path.join( __dirname, 'Uploads/BuktiPembayaran' )));



module.exports = app;
