const { Router } = require('express');
const { getProductsForHomeCarousel,
    getListProductsHome, 
    likeOrUnlikeProduct, 
    productFavoriteForUser,
    getProductsForCategories,
    // saveOrderBuyProducts,
    addNewProduct,
    // getAllPurchasedProducts,
    // getOrderDetailsProducts, 
    deleteProduct, 
    // saveOrderBuyProducts2,
    // updateStatusPembayaran,
    // getAllPurchasedProductsAdmin,
    // saveHistoryKeranjang,
    // getAllKeranjang,
    // getKeranjangDetails
} = require('../Controller/ProductController');
const { validateToken }  = require('../Middlewares/ValidateToken');
const { uploadsProduct, uploadsBuktiPembayaran } = require('../Helpers/Multer');

const router = Router();

    router.get('/product/get-home-products-carousel', validateToken,  getProductsForHomeCarousel );
    router.get('/product/get-products-home', validateToken, getListProductsHome);
    router.post('/product/like-or-unlike-product', validateToken, likeOrUnlikeProduct);
    router.get('/product/get-all-favorite', validateToken, productFavoriteForUser);
    router.get('/product/get-products-for-category/:idCategory', validateToken, getProductsForCategories);
    // router.post('/product/save-order-buy-product', validateToken, saveOrderBuyProducts);
    // router.post('/product/save-order-buy-product-2:uidOrder', [validateToken, uploadsBuktiPembayaran.single('BuktiPembayaranImage')], saveOrderBuyProducts2);
    router.post('/product/add-new-product', [validateToken, uploadsProduct.single('productImage')], addNewProduct);
    // router.get('/product/get-all-purchased-products-admin', validateToken, getAllPurchasedProductsAdmin);
    // router.post('/product/get-all-purchased-products', validateToken, getAllPurchasedProducts);
    // router.get('/product/get-orders-details/:uidOrder', validateToken, getOrderDetailsProducts);
    router.delete('/product/delete-product/:uidP', validateToken, deleteProduct);
    // router.put('/update-status-pembayaran', validateToken, updateStatusPembayaran);
    // router.post('/product/save-history-keranjang', validateToken, saveHistoryKeranjang);
    // router.post('/product/get-all-keranjang-products', validateToken, getAllKeranjang);
    // router.get('/product/get-keranjang-details/:uidKeranjang', validateToken, getKeranjangDetails);


module.exports = router;