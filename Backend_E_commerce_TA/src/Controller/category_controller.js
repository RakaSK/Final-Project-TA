const { response, request } = require('express');
const connet = require('../DataBase/DataBase');

const getAllCategories = async ( req = request, res = response ) => {

    try {

        const conn = await connet();

        const categories = await conn.query('SELECT * FROM category');

        await conn.end();

        return res.json({
            resp: true,
            message: 'Get all categories',
            categories: categories[0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

const addNewCategory = async (req = request, res = response) => {

    try {

        const { name } = req.body;

        const conn = await connet();

        await conn.query('INSERT INTO category (category, picture) VALUE (?,?)', 
            [ name, req.file.filename]);

        await conn.end();   

        return res.json({
            resp: true,
            message: 'Category Added'
        })
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}

const deleteCategory = async (req = request, res = response) => {

    try {

        const conn = await connet();

        await conn.query('DELETE FROM category WHERE uidCategory = ?', [ req.params.uidCategory ]);

        await conn.end();   


        return res.json({
            resp: true,
            message: 'Category Deleted'
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

module.exports = {
    getAllCategories, 
    addNewCategory,
    deleteCategory
}