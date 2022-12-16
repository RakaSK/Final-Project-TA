const multer = require('multer');
const path = require('path');

var storage = multer.diskStorage({
    destination: ( req, res, cb ) => {
        cb(null, 'src/Uploads/Profile')
    },
    filename: ( req, file, cb ) => {
        cb( null, file.fieldname + '-' + Date.now() + path.extname(file.originalname) )
    }
});


var storageProduct = multer.diskStorage({
    destination: ( req, res, cb ) => {
        cb(null, 'src/Uploads/Products')
    },
    filename: ( req, file, cb ) => {
        cb( null, file.fieldname + '-' + Date.now() + path.extname(file.originalname) )
    }
});

var storageCategory = multer.diskStorage({
    destination: ( req, res, cb ) => {
        cb(null, 'src/Uploads/Categories')
    },
    filename: ( req, file, cb ) => {
        cb( null, file.fieldname + '-' + Date.now() + path.extname(file.originalname) )
    }
});

var storageBuktiPembayaran = multer.diskStorage({
    destination: ( req, res, cb ) => {
        cb(null, 'src/Uploads/BuktiPembayaran')
    },
    filename: ( req, file, cb ) => {
        cb( null, file.fieldname + '-' + Date.now() + path.extname(file.originalname) )
    }
});


const uploadsProfile = multer({ storage: storage });
const uploadsProduct = multer({ storage: storageProduct });
const uploadsCategory = multer({ storage: storageCategory });
const uploadsBuktiPembayaran = multer({ storage: storageBuktiPembayaran });



module.exports = {
    uploadsProfile,
    uploadsProduct, 
    uploadsCategory,
    uploadsBuktiPembayaran
}