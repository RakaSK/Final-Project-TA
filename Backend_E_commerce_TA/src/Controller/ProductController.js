const { response, request } = require('express');
const connet = require('../DataBase/DataBase');



const getProductsForHomeCarousel = async ( req = request, res = response ) => {

    try {

        const conn = await connet();

        const rows = await conn.query('SELECT * FROM home_carousel');

        await conn.end();

        return res.json({
            resp: true,
            message: 'Get List products home',
            slideProducts: rows[0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

const getListProductsHome = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const products = await conn.query(`CALL SP_LIST_PRODUCTS_HOME(?);`,[ req.uidPerson ]);

        await conn.end();

        return res.json({
            resp: true,
            message: 'Get List Products for Home',
            listProducts: products[0][0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}

const likeOrUnlikeProduct = async (req = request, res = response) => {

    try {

        const { uidProduct } = req.body;

        const conn = await connet();

        const isLike = await conn.query('SELECT COUNT(uidFavorite) isfavorite FROM favorite WHERE user_id = ? AND product_id = ?', [ req.uidPerson, uidProduct ]);

        if( isLike[0][0].isfavorite > 0 ){

            await conn.query('DELETE FROM favorite WHERE user_id = ? AND product_id = ?', [ req.uidPerson, uidProduct ]);

            await conn.end();

            return res.json({
                resp: true,
                message: 'Unlike'
            });
        }

        await conn.query('INSERT INTO favorite (user_id, product_id) VALUE (?,?)', [ req.uidPerson, uidProduct ]);

        await conn.end();

        return res.json({
            resp: true,
            message: 'Like'
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}


const productFavoriteForUser = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const listProducts = await conn.query(`CALL SP_LIST_FAVORITE_PRODUCTS(?);`, [ req.uidPerson ]);

        await conn.end();

        if(listProducts[0][0].length === 0 ){
            res.json({
                resp: false,
                message : 'Favorite kosong',
                // amount : 0,
                listProducts : []
            });
            
        }else{
            res.json({
                resp: true,
                message : 'List to products favorites',
                listProducts: listProducts[0][0]
            });
        }

        // res.json({
        //     resp: true,
        //     message : 'List to products favorites',
        //     listProducts: listProducts[0][0]
        // });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}

const getProductsForCategories = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const products = await conn.query(`CALL SP_LIST_PRODUCTS_FOR_CATEGORY(?,?);`, [ req.params.idCategory, req.uidPerson ]); 

        await conn.end();

        res.json({
            resp: true,
            message : 'List Products',
            listProducts: products[0][0] 
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

// const saveOrderBuyProducts = async (req = request, res = response) => {

//    try {
       
//     const { receipt, amount, products  } = req.body;

//     const conn = await connet();
 
//     const db = await conn.query('INSERT INTO orderBuy (user_id, receipt, amount) VALUES (?,?,?)', [ req.uidPerson, receipt, amount ]);

//     products.forEach(e => {
//         conn.query('INSERT INTO orderDetails (orderBuy_id, product_id, quantity, price) VALUES (?,?,?,?)', [db[0].insertId, e.uidProduct, e.amount, e.price]);
//         conn.query('UPDATE products SET stock = stock-? WHERE uidProduct = ?', [ e.amount, e.uidProduct ]);
//     });

//     // await conn.end();

//     return res.json({
//         resp: true,
//         message: 'Products save'
//     });


//    } catch (err) {
//     return res.status(500).json({
//         resp: false,
//         message: err
//     });
//    }
// }

// const saveOrderBuyProducts2 = async (req = request, res = response) => {

//     try {
        
//     //  const { picture  } = req.body;
 
//      const conn = await connet();
  
//     //  await conn.query('INSERT INTO orderBuy (user_id, picture) VALUES (?,?)', 
//     //         [ req.uidPerson, req.file.filename ]);

//     await conn.query('UPDATE orderBuy SET picture = ? WHERE user_id = ?', 
//             [ req.file.filename, req.uidPerson ]);

//         await conn.end();   

//         return res.json({
//             resp: true,
//             message: 'Bukti Pembayaran Added'
//         })
        
//     } catch (err) {
//         return res.status(500).json({
//             resp: false,
//             message: err
//         });
//     }
//  }

const addNewProduct = async (req = request, res = response) => {

    try {

        const { name, description, stock, price, uidCategory } = req.body;

        const conn = await connet();

        await conn.query('INSERT INTO products (nameProduct, description, codeProduct, stock, price, picture, category_id) VALUE (?,?,?,?,?,?,?)', 
            [ name, description, '000' + name, stock, price, req.file.filename, uidCategory ]);

        await conn.end();   

        return res.json({
            resp: true,
            message: 'Product Added'
        })
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}

const deleteProduct = async (req = request, res = response) => {

    try {

        const conn = await connet();

        await conn.query('DELETE FROM products WHERE uidProduct = ?', [ req.params.uidP ]);
        console.log(req.params.uidP); 

        await conn.end();   


        return res.json({
            resp: true,
            message: 'Product Deleted'
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

// const getAllPurchasedProductsAdmin = async ( req, res = response ) => {

//     // const { token } = req.body;

//     try {

//         const conn = await connet();

//         // const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE user_id = ?' [ req.uidPerson ]);

//         const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id');

//         await conn.end();

//         res.json({
//             resp: true,
//             msg : 'Get Puchased Products',
//             orderBuy : orderbuy[0],
//         });
        
//     } catch (err) {
        
//     }
   
// }


// const getAllPurchasedProducts = async ( req, res = response ) => {

//     const { token } = req.body;

//     try {

//         const conn = await connet();

//         // const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE user_id = ?' [ req.uidPerson ]);

//         const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE users.token = ?' , [token]);

//         await conn.end();

//         res.json({
//             resp: true,
//             msg : 'Get Puchased Products',
//             orderBuy : orderbuy[0],
//         });
        
//     } catch (err) {
        
//     }
   
// }

// const getOrderDetailsProducts = async ( req, res = response ) => {

//     try {

//         const conn = await connet();

//         const orderDetails = await conn.query(`CALL SP_ORDER_DETAILS(?);`, [req.params.uidOrder]);

//         await conn.end();

//         res.json({
//             resp: true,
//             msg : 'Get Puchased Products',
//             orderDetails : orderDetails[0][0],
//         });
        
//     } catch (err) {
        
//     }
   
// }


// const updateStatusPembayaran = async (req = request, res = response) => {

//     try {

//         const conn = await connet();

//         const { status, uidOrderBuy } = req.body;

//         await conn.query('UPDATE orderBuy SET status = ? WHERE uidOrderBuy = ?', [ parseInt(status), parseInt(uidOrderBuy) ]);

//         // await conn.query('UPDATE orderBuy SET status = ? WHERE uidOrderBuy = ?', [ req.status, req.uidOrderBuy ]);

//         await conn.end();   

//         return res.json({
//             resp: true,
//             message: 'Pembayaran Updated'
//         });
        
//     } catch (err) {
//         return res.status(500).json({
//             resp: false,
//             message: err
//         });
//     }

// }

// const saveHistoryKeranjang = async (req = request, res = response) => {

//     try {
        
//      const { receipt, amount, products  } = req.body;
 
//      const conn = await connet();

//     //  const cekKeranjang = await conn.query('SELECT uidKeranjang from keranjang where user_id ?', [req.uidPerson]);

//     const existsKeranjang = await conn.query('SELECT uidKeranjang,amount from keranjang where user_id = ?', [req.uidPerson]);

//     if( existsKeranjang[0].length === 0 ){
//      const db = await conn.query('INSERT INTO keranjang (user_id, receipt, amount) VALUES (?,?,?)', [ req.uidPerson, receipt, amount ]);
//      amount = 0; 
//      products.forEach(e => {
//         // amount = amount+e.price; 
//         conn.query('INSERT INTO keranjangdetails (keranjang_id, product_id, quantity, price) VALUES (?,?,?,?)', [db[0].insertId, e.uidProduct, e.amount, e.price]);
//     });

//     conn.query('UPDATE keranjang SET amount = ? WHERE uidKeranjang = ?' [amount, db[0].insertId] );

//     } else {//PENAMBAHAN ITEM KERANJANG
//         products.forEach(e => {
//          const db = conn.query('INSERT INTO keranjangdetails (keranjang_id, product_id, quantity, price) VALUES (?,?,?,?)', [existsKeranjang[0][0].uidKeranjang, e.uidProduct, e.amount, e.price]);
//          amountKeranjang = existsKeranjang[0][0].amount;
//          jumlah = amountKeranjang+e.price;
//          conn.query('UPDATE keranjang SET amount = ? WHERE uidKeranjang = ?',[jumlah, existsKeranjang[0][0].uidKeranjang.toString()] );
//      });
//     }
  
//     //  const db = await conn.query('INSERT INTO keranjang (user_id, receipt, amount) VALUES (?,?,?)', [ req.uidPerson, receipt, amount ]);
       
//      // await conn.end();
 
//      return res.json({
//          resp: true,
//          message: 'Products save'
//     });
 
//     } catch (err) {
//      return res.status(500).json({
//          resp: false,
//          message: err
//      });
//     }
// }

// const deleteHistoryKeranjang = async (req = request, res = response) => {

//     try {

//         const conn = await connet();

//         await conn.query('DELETE FROM keranjang WHERE uidKeranjang = ?', [ req.params.uidKeranjang ]);
//         await conn.query('DELETE FROM keranjangdetails WHERE uidKeranjangDetails = ?', [ req.params.uidKeranjangDetails ]);

//         await conn.end();   


//         return res.json({
//             resp: true,
//             message: 'Keranjang Deleted'
//         });
        
//     } catch (err) {
//         return res.status(500).json({
//             resp: false,
//             message: err
//         });
//     }

// }

// // const getAllKeranjang = async ( req, res = response ) => {


// //     const { token } = req.body;

// //     try {

// //         const conn = await connet();

// //         // const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE user_id = ?' [ req.uidPerson ]);

// //         // console.log(token);

// //         // const keranjang = await conn.query('SELECT keranjang.* FROM keranjang JOIN users on keranjang.user_id = users.id WHERE users.token = ?' , [token]);


// //         const keranjang = await conn.query('SELECT keranjang.* , keranjangdetails.* , products.nameProduct , products.picture FROM keranjang JOIN users on keranjang.user_id = users.id JOIN keranjangdetails on keranjang.uidKeranjang = keranjangdetails.keranjang_id JOIN products on products.uidProduct = keranjangdetails.product_id WHERE users.token = ?' , [token]);

// //         await conn.end();

// //         res.json({
// //             resp: true,
// //             msg : 'Get Puchased Products',
// //             amount : keranjang[0][0].amount,
// //             keranjang : keranjang[0]
// //         });
        
// //     } catch (err) {
        
// //     }
   
// // }

// const getKeranjangDetails = async ( req, res = response ) => {

//     try {

//         const conn = await connet();

//         // const keranjangDetails = await conn.query(`CALL SP_ORDER_DETAILS(?);`, [req.params.uidOrder]);

//         const keranjangdetails = await conn.query('SELECT * FROM keranjangdetails JOIN products on keranjangdetails.product_id = products.uidProduct WHERE keranjangdetails.keranjang_id = ?' , [ID]);


//         await conn.end();

//         res.json({
//             resp: true,
//             msg : 'Get Puchased Products',
//             keranjangdetails : keranjangdetails[0][0],
//         });
        
//     } catch (err) {
        
//     }
   
// }



module.exports = {
    getProductsForHomeCarousel,
    getListProductsHome,
    likeOrUnlikeProduct,
    productFavoriteForUser,
    // saveOrderBuyProducts,
    // saveOrderBuyProducts2,
    getProductsForCategories,
    addNewProduct,
    deleteProduct,
    // getAllPurchasedProductsAdmin, 
    // getAllPurchasedProducts,
    // getOrderDetailsProducts,
    // updateStatusPembayaran, 
    // saveHistoryKeranjang,
    // deleteHistoryKeranjang,
    // getAllKeranjang,
    // getKeranjangDetails
}