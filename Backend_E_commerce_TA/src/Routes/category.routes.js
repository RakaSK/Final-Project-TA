const { Router } = require('express');
const { validateToken }  = require('../Middlewares/ValidateToken');
const { getAllCategories, addNewCategory, deleteCategory } = require('../Controller/category_controller');
const { uploadsCategory } = require('../Helpers/Multer');

const router = Router();

router.get('/category/get-all-categories', validateToken,  getAllCategories );
router.post('/category/add-new-category', [validateToken, uploadsCategory.single('categoryImage')], addNewCategory);
router.delete('/category/delete-category/:uidCategory', validateToken, deleteCategory);

module.exports = router;