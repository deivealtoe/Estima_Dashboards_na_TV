const express = require('express');
const oracledb = require('oracledb');
const oracle_info = require('../_config/oracle_info.json');

const router = express.Router();

router.get('/mixes', async (request, response) => {

    try {
        conn = await oracledb.getConnection({
            user: oracle_info.user,
            password: oracle_info.password,
            connectString: oracle_info.connectString
        });

        const resultado = await conn.execute(`SELECT * FROM dashoff_fabric_mixes`);

        await conn.close();
        
        //console.log(resultado.rows);

        let labels = [];
        let mixProduto = [];
        let metaMixProduto = [];
        let mixCliente = [];
        let metaMixCliente = [];

        resultado.rows.forEach((elemento, index, array) => {
            labels.push(elemento[0]);
            mixProduto.push(elemento[1]);
            metaMixProduto.push(elemento[2]);
            mixCliente.push(elemento[3]);
            metaMixCliente.push(elemento[4]);
        });

        /*console.log(labels);
        console.log(mixProduto);
        console.log(metaMixProduto);
        console.log(mixCliente);
        console.log(metaMixCliente);*/

        return response.json({ labels, mixProduto, metaMixProduto, mixCliente, metaMixCliente });
    } catch (error) {
        console.log(error);
    }
    
    return response.json({ msg: "Deu ruim! Dá uma olhad ano LOG do console!" });
});

router.get('/vendas', async (request, response) => {

    try {
        conn = await oracledb.getConnection({
            user: oracle_info.user,
            password: oracle_info.password,
            connectString: oracle_info.connectString
        });

        const resultado = await conn.execute(`SELECT * FROM dashoff_fabric_vendas`);

        await conn.close();
        
        //console.log(resultado.rows);

        let labels = [];
        let totalVendido = [];
        let metaVenda = [];

        resultado.rows.forEach((elemento, index, array) => {
            labels.push(elemento[0]);
            totalVendido.push(elemento[1]);
            metaVenda.push(elemento[2]);
        });

        /*console.log(labels);
        console.log(totalVendido);
        console.log(metaVenda);*/

        return response.json({ labels, totalVendido, metaVenda });
    } catch (error) {
        console.log(error);
    }
    
    return response.json({ msg: "Deu ruim! Dá uma olhad ano LOG do console!" });
});

module.exports = router;