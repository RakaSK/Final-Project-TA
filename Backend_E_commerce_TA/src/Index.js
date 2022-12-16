
const app = require('./app');
const port = process.env.PORT || 7070; 


app.get("/", (req, res)=> res.send("Koneksi Anda Berhasil !!"))


app.listen( port, () => console.log('Listen on port ' + process.env.PORT) );