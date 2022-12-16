const { response, request } = require('express');
const connet = require('../DataBase/DataBase');


// const saveHistoryKeranjang = async (req = request, res = response) => {

//     try {
        
//      const { receipt, amount, products, uidProduct, price, amount2  } = req.body;
 
//      const conn = await connet();
//     // console.log('saveHistoryKeranjang'); 

//     //  const cekKeranjang = await conn.query('SELECT uidKeranjang from keranjang where user_id ?', [req.uidPerson]);

//     const existsKeranjang = await conn.query('SELECT uidKeranjang,amount from keranjang where user_id = ?', [req.uidPerson]);

//     if( existsKeranjang[0].length === 0 ){
//      const db = await conn.query('INSERT INTO keranjang (user_id, receipt, amount) VALUES (?,?,?)', [ req.uidPerson, receipt, amount ]);
//      amount = 0; 
//     //  products.forEach(e => {
//         amount = amount+amount2; 
//         conn.query('INSERT INTO keranjangdetails (keranjang_id, product_id, quantity, price) VALUES (?,?,?,?)', [db[0].insertId, uidProduct, amount, price]);
//     // });

    

//     console.log(amount); 
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

//         // await conn.query('DELETE FROM keranjang WHERE uidKeranjang = ?', [ req.params.uidKeranjang ]);
//         const existsKeranjang = await conn.query('SELECT uidKeranjang,amount from keranjang where user_id = ?', [req.uidPerson]);
//         if( existsKeranjang[0].length === 1 ){
//             await conn.query('DELETE FROM keranjangdetails WHERE uidKeranjangDetails = ?', [ req.params.uidKeranjangDetails ]);
//             // existsKeranjang[0][0].uidKeranjang
//             await conn.query('DELETE FROM keranjang WHERE uidKeranjang = ?', [ existsKeranjang[0][0].uidKeranjang ]);
       
//         } else {//PENAMBAHAN ITEM KERANJANG
//             await conn.query('DELETE FROM keranjangdetails WHERE uidKeranjangDetails = ?', [ req.params.uidKeranjangDetails ]);
            
//         }

        

//         console.log(req.params.uidKeranjangDetails); 

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

const saveHistoryKeranjang = async (req = request, res = response) => {

    try {
        
     const { receipt, amount, products  } = req.body;
 
     const conn = await connet();

    //  const cekKeranjang = await conn.query('SELECT uidKeranjang from keranjang where user_id ?', [req.uidPerson]);

    const existsKeranjang = await conn.query('SELECT uidKeranjang,amount from keranjang where user_id = ?', [req.uidPerson]);

    if( existsKeranjang[0].length === 0 ){
        console.log("KERANJANG 0");
        console.log("AMOUNT "+amount);
        const db = await conn.query('INSERT INTO keranjang (user_id, receipt, amount) VALUES (?,?,?)', [ req.uidPerson, receipt, amount ]);
        console.log("habis insert keranjang");
        console.log(products.length);
        var amountAwal = "0";
        products.forEach(e => {
            amountAwal = e.price; 
            conn.query('INSERT INTO keranjangdetails (keranjang_id, product_id, quantity, price) VALUES (?,?,?,?)', [db[0].insertId, e.uidProduct, e.amount, e.price]);
        });

    } else {//PENAMBAHAN ITEM KERANJANG
        products.forEach(e => {
         const db = conn.query('INSERT INTO keranjangdetails (keranjang_id, product_id, quantity, price) VALUES (?,?,?,?)', [existsKeranjang[0][0].uidKeranjang, e.uidProduct, e.amount, e.price]);
         amountKeranjang = existsKeranjang[0][0].amount;
         jumlah = amountKeranjang+e.price;
         conn.query('UPDATE keranjang SET amount = ? WHERE uidKeranjang = ?',[jumlah, existsKeranjang[0][0].uidKeranjang.toString()] );
     });
    }

    // const cekkeranjangdetails = conn.query("SELECT uidKeranjangDetails FROM keranjangdetails WHERE product_id=?", [e.uidProduct]);
    //      if(cekkeranjangdetails[0].length === 0) {
    //         const db = conn.query('INSERT INTO keranjangdetails (keranjang_id, product_id, quantity, price) VALUES (?,?,?,?)', [existsKeranjang[0][0].uidKeranjang, e.uidProduct, e.amount, e.price]);

    //      } else {
    //         const updatekeranjangdetails = conn.query("UPDATE keranjangdetails SET quantity = quantity+1 WHERE product_id=?", [e.uidProduct]);
    //      }
  
    //  const db = await conn.query('INSERT INTO keranjang (user_id, receipt, amount) VALUES (?,?,?)', [ req.uidPerson, receipt, amount ]);
       
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


// const deleteHistoryKeranjang = async (req = request, res = response) => {

//     try {

//         const conn = await connet();

//         // const existsKeranjangDetails = await conn.query('SELECT keranjang.* , keranjangdetails.* FROM keranjang JOIN keranjangdetails on keranjang.uidKeranjang = keranjangdetails.keranjang_id ');

//         const existsKeranjangDetails = await conn.query('SELECT keranjang_id , uidKeranjangDetails FROM keranjangdetails');
//         // console.log("keranjang id : ", existsKeranjangDetails[0][0].keranjang_id);
//         if(existsKeranjangDetails[0].length > 1){
//             console.log("cek klo data >1");
//             console.log('uiddetail', req.params.uidKeranjangDetails);
//             const db = await conn.query('DELETE FROM keranjangdetails WHERE uidKeranjangDetails = ?', [ req.params.uidKeranjangDetails ]);
//             // conn.query('DELETE FROM keranjang WHERE uidKeranjang = ?', [ req.params.uidKeranjang ]);
            
//         } else {
//             // var keranjang_id = existsKeranjangDetails[0][0].keranjang_id;
//             // if(existsKeranjangDetails[0].length === 0) {
//                 // console.log("keranjang id :"+keranjang_id);
//                 console.log("keranjang id : ", existsKeranjangDetails[0][0].keranjang_id);
//                 console.log("cek klo data=0");
//                 await conn.query('DELETE FROM keranjangdetails WHERE uidKeranjangDetails = ?', [ req.params.uidKeranjangDetails ]);
//                 console.log("delete keranjang");
//                 await conn.query('DELETE FROM keranjang WHERE uidKeranjang = ?', [ existsKeranjangDetails[0][0].keranjang_id ]);
//             // }
//         }


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

const deleteHistoryKeranjang = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const existsKeranjangDetails = await conn.query('SELECT keranjang_id , uidKeranjangDetails, price FROM keranjangdetails');
        if(existsKeranjangDetails[0].length > 1){
        
            const db = await conn.query('DELETE FROM keranjangdetails WHERE uidKeranjangDetails = ?', [ req.params.uidKeranjangDetails ]);
            const existsKeranjang = await conn.query('SELECT amount FROM keranjang where uidKeranjang = ?', [existsKeranjangDetails[0][0].keranjang_id]);
            var amount = existsKeranjang[0][0].amount;
            amount = existsKeranjang[0][0].amount-existsKeranjangDetails[0][0].price;
            await conn.query('UPDATE keranjang SET amount = ? WHERE uidKeranjang = ?', [amount, existsKeranjangDetails[0][0].keranjang_id ]);
            
        } else {
                await conn.query('DELETE FROM keranjangdetails WHERE uidKeranjangDetails = ?', [ req.params.uidKeranjangDetails ]);
                await conn.query('DELETE FROM keranjang WHERE uidKeranjang = ?', [ existsKeranjangDetails[0][0].keranjang_id ]);
        }

        await conn.end();   

        return res.json({
            resp: true,
            message: 'Keranjang Deleted'
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}


const getAllKeranjang = async ( req, res = response ) => {


    const { token } = req.body;

    try {

        const conn = await connet();

        // const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE user_id = ?' [ req.uidPerson ]);

        // console.log(token);

        // const keranjang = await conn.query('SELECT keranjang.* FROM keranjang JOIN users on keranjang.user_id = users.id WHERE users.token = ?' , [token]);


        const keranjang = await conn.query('SELECT keranjang.* , keranjangdetails.* , products.nameProduct , products.picture , products.price as priceawal FROM keranjang JOIN users on keranjang.user_id = users.id JOIN keranjangdetails on keranjang.uidKeranjang = keranjangdetails.keranjang_id JOIN products on products.uidProduct = keranjangdetails.product_id WHERE users.token = ?' , [token]);

        await conn.end();

        if(keranjang[0].length === 0 ){
            res.json({
                resp: false,
                msg : 'Keranjang kosong',
                amount : 0,
                keranjang : []
            });
            
        }else{
            res.json({
                resp: true,
                msg : 'Get Puchased Products',
                amount : keranjang[0][0].amount,
                keranjang : keranjang[0]
            });
        }
        
    } catch (err) {
        
    }
   
}

const getKeranjangHarga = async ( req, res = response ) => {


    const { token } = req.body;

    try {

        const conn = await connet();

        // const orderbuy = await conn.query('SELECT * FROM orderBuy JOIN users on orderbuy.user_id = users.id WHERE user_id = ?' [ req.uidPerson ]);

        // console.log(token);

        // const keranjang = await conn.query('SELECT keranjang.* FROM keranjang JOIN users on keranjang.user_id = users.id WHERE users.token = ?' , [token]);


        const keranjang = await conn.query('SELECT keranjang.* , keranjangdetails.* , products.nameProduct , products.picture FROM keranjang JOIN users on keranjang.user_id = users.id JOIN keranjangdetails on keranjang.uidKeranjang = keranjangdetails.keranjang_id JOIN products on products.uidProduct = keranjangdetails.product_id WHERE users.token = ?' , [token]);

        const jumlahquantity = await conn.query('SELECT SUM(quantity) as jumlah FROM keranjang JOIN users on keranjang.user_id = users.id JOIN keranjangdetails on keranjang.uidKeranjang = keranjangdetails.keranjang_id JOIN products on products.uidProduct = keranjangdetails.product_id WHERE users.token = ?' , [token]);

        await conn.end();

        if(keranjang[0].length === 0 ){
            res.json({
                resp: false,
                msg : 'Keranjang kosong',
                amount : 0,
                jumlahquantity : 0,
                keranjang : []
            });
            
        }else{
            res.json({
                resp: true,
                msg : 'Get Puchased Products',
                amount : keranjang[0][0].amount,
                jumlahquantity : jumlahquantity[0][0].jumlah,
                uidKeranjang : keranjang[0][0].uidKeranjang
            });
        }
        
    } catch (err) {
        
    }
   
}

const getKeranjangDetails = async ( req, res = response ) => {

    try {

        const conn = await connet();

        // const keranjangDetails = await conn.query(`CALL SP_ORDER_DETAILS(?);`, [req.params.uidOrder]);

        const keranjangdetails = await conn.query('SELECT * FROM keranjangdetails JOIN products on keranjangdetails.product_id = products.uidProduct WHERE keranjangdetails.keranjang_id = ?' , [ID]);


        await conn.end();

        res.json({
            resp: true,
            msg : 'Get Puchased Products',
            keranjangdetails : keranjangdetails[0][0],
        });
        
    } catch (err) {
        
    }
   
}

const changeItemKeranjang = async (req, res = response) => {
    const { uidKeranjangDetails, jenis } = req.body;
    const conn = await connet();
    try {
        const existsKeranjangDetail = await conn.query('SELECT quantity,product_id,price,keranjang_id from keranjangdetails where uidKeranjangDetails = ?', [uidKeranjangDetails]);
        
        if( existsKeranjangDetail[0].length === 0 ){
            return res.json({
                resp: false,
                message: 'Detail id '+uidKeranjangDetails+' tidak ditemukan'
            });
        }else{
            console.log("ada itemhnya");
            //CEK KERANJANG
            var keranjang_id = existsKeranjangDetail[0][0].keranjang_id;
            const keranjang = await conn.query('SELECT amount from keranjang where uidKeranjang = ?',[keranjang_id]);
            if(keranjang[0].length === 0){
                return res.json({
                    resp: false,
                    message: 'Keranjang id '+keranjang_id+' tidak ditemukan'
                });
            }
            var total_amount_keranjang = keranjang[0][0].amount;
            var product_id = existsKeranjangDetail[0][0].product_id;
            const product = await conn.query('SELECT * from products where uidProduct = ?', [product_id]);
            if(product[0].length === 0){
                return res.json({
                    resp: false,
                    message: 'Product id '+product_id+' tidak ditemukan'
                });
            }else{
                console.log("ada product");
                var product_price = product[0][0].price;
                var product_stock = product[0][0].stock;
                if(jenis == 'plus'){
                    console.log("add item ===========");
                    if(product_stock == 0){
                        console.log("stok habis");
                        return res.json({
                            resp: false,
                            message: 'Stock habis'
                        });
                    }else{
                        var new_price_item = existsKeranjangDetail[0][0].price + product_price;
                        var new_qty_item = existsKeranjangDetail[0][0].quantity + 1;
                        var new_stock = product_stock-1;
                       
                        
                        console.log("new price", new_price_item);
                        console.log("new qty", new_qty_item);
                        console.log("new stock", new_stock);
                        
                        await conn.query('UPDATE keranjangdetails SET quantity = ?, price = ? where uidKeranjangDetails = ?', [new_qty_item, new_price_item, uidKeranjangDetails]);
                        // await conn.query('UPDATE products SET stock = ? where uidProduct = ?', [new_stock, product_id]);
                        
                    }
                }else{
                    console.log("substact item ===========");
                    if(existsKeranjangDetail[0][0].quantity == 1){
                        return res.json({
                            resp: false,
                            message: 'Jumlah Produk minimal 1'
                        });
                    }
                    var new_price_item =  existsKeranjangDetail[0][0].price - product_price;
                    var new_qty_item = existsKeranjangDetail[0][0].quantity - 1;
                    console.log("new price", new_price_item);
                    console.log("new qty", new_qty_item);
                    var new_stock = product_stock+1;
                    console.log("new stock", new_stock);
                    await conn.query('UPDATE keranjangdetails SET quantity = ?, price = ? where uidKeranjangDetails = ?', [new_qty_item, new_price_item, uidKeranjangDetails]);
                    // await conn.query('UPDATE products SET stock = ? where uidProduct = ?', [new_stock, product_id]);
                }
                const total_amount = await conn.query('SELECT sum(price) as jml from keranjangdetails where keranjang_id = ?', [keranjang_id]);
                    var new_total_amount_keranjang = total_amount[0][0].jml;
                    await conn.query('UPDATE keranjang SET amount = ? where uidKeranjang = ?', [new_total_amount_keranjang, keranjang_id]);
                console.log("new total amount", total_amount[0][0].jml);
                return res.json({
                    resp: true,
                    message: 'Berhasil '+jenis+' product',
                    value: new_qty_item
                });
            }
        }
    } catch (err) {
        console.log(err);
    }
    await conn.end();
    
}


module.exports = {
    saveHistoryKeranjang,
    deleteHistoryKeranjang,
    getAllKeranjang,
    getKeranjangHarga,
    getKeranjangDetails, 
    changeItemKeranjang
}