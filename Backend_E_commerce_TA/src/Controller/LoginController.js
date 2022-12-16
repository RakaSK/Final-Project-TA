
const {response, request} = require('express');
const connet = require('../DataBase/DataBase');
const bcrypt = require('bcrypt');
const { generarJsonWebToken } = require('../Helpers/JWToken');


const LoginUsuario = async ( req = request, res = response ) => {

    const { email, passwordd } = req.body;

   try {

        const conn = await connet();

        const existsEmail = await conn.query('SELECT role, id, email, passwordd FROM users WHERE email = ? LIMIT 1', [ email ]);


        if( existsEmail[0].length === 0 ){
            conn.end();
            return res.status(400).json({
                resp: false,
                message : 'Wrong Credentials'
            });
        }


        const validatedPassword = await bcrypt.compareSync( passwordd, existsEmail[0][0].passwordd );

        if( !validatedPassword ){

            conn.end();
            return res.status(400).json({
                resp: false,
                message: 'Wrong Credentials'
            }); 
            
        }

        const token = await generarJsonWebToken( existsEmail[0][0].id );
        const updatetoken = await conn.query('UPDATE users SET token = ? WHERE email = ?', [ token, email ]);
                
        conn.end();
        return res.json({
            resp: true,
            message : 'Welcome to DNI Shop',
            token: token,
            role: existsEmail[0][0].role
        });

        

   } catch (err) {
        return res.status(500).json({
            resp: false,
            message : err
        });
   }
}

const RenweToken = async ( req = request , res = response ) => {

    const conn = await connet();

    const token = await generarJsonWebToken( req.uidPerson );
    const updatetoken = await conn.query('UPDATE users SET token = ? WHERE id = ?', [ token, req.uidPerson ]);
   
    return res.json({
        resp: true,
        message : 'Welcome to DNI Shop',
        token: token
    });
    
}


module.exports = {
    LoginUsuario,
    RenweToken,
};