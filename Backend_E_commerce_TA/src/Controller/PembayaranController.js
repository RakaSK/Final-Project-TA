const { response, request } = require('express');
const connet = require('../DataBase/DataBase');


const saveOrderBuyProducts = async (req = request, res = response) => {

   try {
       
    const { receipt, amount, products  } = req.body;

    const conn = await connet();
 
    const db = await conn.query('INSERT INTO orderbuy (user_id, receipt, amount) VALUES (?,?,?)', [ req.uidPerson, receipt, amount ]);

    products.forEach(e => {
        conn.query('INSERT INTO orderdetails (orderBuy_id, product_id, quantity, price) VALUES (?,?,?,?)', [db[0].insertId, e.uidProduct, e.amount, e.price]);
        conn.query('UPDATE products SET stock = stock-? WHERE uidProduct = ?', [ e.amount, e.uidProduct ]);
    });

    // await conn.end();

    return res.json({
        resp: true,
        message: 'Products save'
    });


   } catch (err) {
    return res.status(500).json({
        resp: false,
        message: err
    });
   }
}

const saveOrderBuyProducts1 = async (req = request, res = response) => {

    try {
        
     const { total, ongkir, kota_tujuan, estimasi, layanankirim, namakurir  } = req.body;
 
     const conn = await connet();

     const keranjang = await conn.query('SELECT uidKeranjang FROM keranjang WHERE user_id=?', [req.uidPerson]); 
  
     
     const order = await conn.query('INSERT INTO orderbuy (user_id, receipt, amount) SELECT user_id, receipt, amount From keranjang WHERE user_id=?', [ req.uidPerson ]);
     
     const updateamount = await conn.query('UPDATE orderbuy set amount = ?, ongkir = ?, kota_tujuan = ?, estimasi = ?, layanankirim = ?, namakurir = ? WHERE uidOrderBuy=?', [total, ongkir, kota_tujuan, estimasi, layanankirim, namakurir, order[0].insertId]); 


    //  const detailOrder = await conn.query('INSERT INTO orderDetails ( product_id, quantity, price) SELECT product_id, quantity, price From keranjangdetails JOIN keranjang ON keranjang.uidKeranjang=keranjangdetails.keranjang_id WHERE keranjang.user_id=?', [ req.uidPerson ]);

    //  const updatedetailOrder = await conn.query('UPDATE orderDetails SET orderBuy_id = ? WHERE uidOrderDetails = ? ', [ order[0].insertId, detailOrder[0].insertId ]);

     const detailOder1 = await conn.query('SELECT keranjangdetails.product_id, keranjangdetails.quantity, keranjangdetails.price FROM keranjangdetails JOIN keranjang ON keranjang.uidKeranjang=keranjangdetails.keranjang_id WHERE keranjang.user_id=?' , [ req.uidPerson ]);

     console.log(detailOder1[0]);

     detailOder1[0].forEach(e => {
        conn.query('INSERT INTO orderdetails (orderBuy_id, product_id, quantity, price) VALUES (?,?,?,?)', [order[0].insertId, e.product_id, e.quantity, e.price]);
        // conn.query('UPDATE products SET stock = stock-? WHERE uidProduct = ?', [ e.quantity, e.product_id ]);

        console.log(e.product_id.toString()); 
    });

    const deleteKeranjangDetails = await conn.query('DELETE FROM keranjangdetails WHERE keranjang_id=?', [keranjang[0][0].uidKeranjang]);
    const deleteKeranjang = await conn.query('DELETE FROM keranjang WHERE uidKeranjang=?', [keranjang[0][0].uidKeranjang]);

 
    //  console.log(req.uidPerson); 
 
     // await conn.end();
 
     return res.json({
         resp: true,
         message: 'Products save'
     });
 
 
    } catch (err) {
     return res.status(500).json({
         resp: false,
         message: err
     });
    }
}


const saveOrderBuyProducts2 = async (req = request, res = response) => {

    try {
        
     const { uidOrder  } = req.body;
 
     const conn = await connet();

     const order = await conn.query('SELECT uidOrderBuy FROM orderbuy WHERE user_id=?', [req.uidPerson]); 

  
    //  await conn.query('INSERT INTO orderBuy (user_id, picture) VALUES (?,?)', 
    //         [ req.uidPerson, req.file.filename ]);
    
    // console.log(req.params.uidOrderBuy); 

    await conn.query('UPDATE orderbuy SET picture = ? WHERE uidOrderBuy = ?', 
            [ req.file.filename, uidOrder ]);

        await conn.end();   

        return res.json({
            resp: true,
            message: 'Bukti Pembayaran Added'
        })
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}

const deleteBuktiBayar = async (req = request, res = response) => {

    try {

        const { uidOrder  } = req.body;
 
        const conn = await connet();

        await conn.query('UPDATE orderbuy SET picture = "" WHERE uidOrderBuy = ?', [ uidOrder ]);

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


const getAllPurchasedProductsAdmin = async ( req, res = response ) => {

    // const { token } = req.body;

    try {

        const conn = await connet();

        // const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE user_id = ?' [ req.uidPerson ]);

        const orderbuy = await conn.query('SELECT * FROM orderbuy JOIN users on orderbuy.user_id = users.persona_id JOIN person on orderbuy.user_id = person.uid');

        await conn.end();

        res.json({
            resp: true,
            msg : 'Get Puchased Products',
            orderBuy : orderbuy[0],
        });
        
    } catch (err) {
        
    }
   
}


const getAllPurchasedProducts = async ( req, res = response ) => {

    const { token } = req.body;

    try {

        const conn = await connet();

        // const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE user_id = ?' [ req.uidPerson ]);

        const orderbuy = await conn.query('SELECT * FROM orderbuy JOIN users on orderbuy.user_id = users.id JOIN person on orderbuy.user_id = person.uid WHERE users.token = ?' , [token]);

        await conn.end();

        // res.json({
        //     resp: true,
        //     msg : 'Get Puchased Products',
        //     orderBuy : orderbuy[0],
        // });

        if(orderbuy[0].length === 0 ){
            res.json({
                resp: false,
                msg : 'History belanja kosong',
                // amount : 0,
                orderBuy : []
            });
            
        }else{
            res.json({
                resp: true,
                msg : 'Get Puchased Products',
                // amount : orderbuy[0][0].amount,
                orderBuy : orderbuy[0]
            });
        }
        
    } catch (err) {
        
    }
   
}

const getOrderDetailsProducts = async ( req, res = response ) => {

    try {

        const conn = await connet();

        // const orderDetails = await conn.query(`CALL SP_ORDER_DETAILS(?);`, [req.params.uidOrder]);

        const orderDetails = await conn.query(`SELECT o.uidOrderDetails, o.orderBuy_id, orderBuy.picture as bukti_pembayaran, o.product_id, p.nameProduct, p.picture, o.quantity, o.price, p.price as priceawal FROM orderdetails o
        INNER JOIN products p ON o.product_id = p.uidProduct
        RIGHT JOIN orderBuy ON orderBuy.uidOrderBuy = o.orderBuy_id 
        WHERE o.orderBuy_id = ?`, [req.params.uidOrder]);


        await conn.end();

        res.json({
            resp: true,
            msg : 'Get Puchased Products',
            bukti_pembayaran : orderDetails[0][0].bukti_pembayaran,
            orderDetails : orderDetails[0],
        });
        
    } catch (err) {
        
    }
   
}


const updateStatusPembayaran = async (req = request, res = response) => {

    try {

        const { status, uidOrderBuy } = req.body;
        
        const conn = await connet();


        await conn.query('UPDATE orderbuy SET status = ? WHERE uidOrderBuy = ?', [ parseInt(status), parseInt(uidOrderBuy) ]);


        console.log(uidOrderBuy); 

        const detailOder1 = await conn.query('SELECT orderdetails.product_id, orderdetails.quantity, orderdetails.price FROM orderdetails JOIN orderbuy ON orderbuy.uidOrderBuy=orderdetails.orderBuy_id WHERE orderbuy.uidOrderBuy=?' , [ uidOrderBuy ]);

        console.log(detailOder1[0]);

        detailOder1[0].forEach(e => {
            
            conn.query('UPDATE products SET stock = stock-? WHERE uidProduct = ?', [ e.quantity, e.product_id ]);

            console.log(e.product_id.toString()); 
            console.log(e.quantity.toString()); 
            
        }); 

        return res.json({
            resp: true,
            message: 'Pembayaran Updated'
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}




module.exports = {
    saveOrderBuyProducts,
    saveOrderBuyProducts1,
    saveOrderBuyProducts2,
    deleteBuktiBayar,
    getAllPurchasedProducts,
    getOrderDetailsProducts,
    getAllPurchasedProductsAdmin, 
    updateStatusPembayaran, 
}