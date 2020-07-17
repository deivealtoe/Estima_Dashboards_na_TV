async function fetchMixesFabricante() {



    // FETCH PARA MIXES DE FABRICANTE
    let response = await fetch('http://127.0.0.1:3000/api/fabricante/mixes', {
        method: 'get'
    });

    let responseJson = await response.json();

    console.log(responseJson);

    var ctx = document.getElementById('fabricante_mixes').getContext('2d');
    var fabricante_mixes = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: responseJson.labels/*['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange']*/,
            datasets: [
                {
                    label: 'Realizado Mix de Produto',
                    data: responseJson.mixProduto/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(255, 0, 0, 1)',
                    borderColor: 'rgba(255, 0, 0, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Meta para Mix de Produto',
                    data: responseJson.metaMixProduto/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(0, 255, 0, 1)',
                    borderColor: 'rgba(255, 255, 255, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Realizado Mix de Cliente',
                    data: responseJson.mixCliente/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(0, 0, 255, 1)',
                    borderColor: 'rgba(0, 0, 255, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Meta para Mix de Cliente',
                    data: responseJson.metaMixCliente/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(247, 162, 46, 1)',
                    borderColor: 'rgba(247, 162, 46, 1)',
                    borderWidth: 0
                }
            ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });



    ///////////////////////////////////////////


    // FETCH PARA MIXES DE VENDEDOR
    response = await fetch('http://127.0.0.1:3000/api/vendedor/mixes', {
        method: 'get'
    });

    responseJson = await response.json();

    console.log(responseJson);

    var ctx = document.getElementById('vendedor_mixes').getContext('2d');
    var vendedor_mixes = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: responseJson.labels/*['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange']*/,
            datasets: [
                {
                    label: 'Realizado Mix de Produto',
                    data: responseJson.mixProduto/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(255, 0, 0, 1)',
                    borderColor: 'rgba(255, 0, 0, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Meta para Mix de Produto',
                    data: responseJson.metaMixProduto/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(0, 255, 0, 1)',
                    borderColor: 'rgba(255, 255, 255, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Realizado Mix de Cliente',
                    data: responseJson.mixCliente/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(0, 0, 255, 1)',
                    borderColor: 'rgba(0, 0, 255, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Meta para Mix de Cliente',
                    data: responseJson.metaMixCliente/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(247, 162, 46, 1)',
                    borderColor: 'rgba(247, 162, 46, 1)',
                    borderWidth: 0
                }
            ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });



    // FETCH PARA VENDAS DE FABRICANTES
    response = await fetch('http://127.0.0.1:3000/api/fabricante/vendas', {
        method: 'get'
    });

    responseJson = await response.json();

    console.log(responseJson);

    var ctx = document.getElementById('fabricante_vendas').getContext('2d');
    var fabricante_vendas = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: responseJson.labels/*['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange']*/,
            datasets: [
                {
                    label: 'Realizado de Vendas',
                    data: responseJson.totalVendido/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(255, 0, 0, 1)',
                    borderColor: 'rgba(255, 0, 0, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Meta de Venda',
                    data: responseJson.metaVenda/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(0, 255, 0, 1)',
                    borderColor: 'rgba(0, 255, 0, 1)',
                    borderWidth: 0
                }
            ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        precision: 2,
                        stepSize: 300000
                    }
                }]
            }
        }
    });



    // FETCH PARA VENDAS DE VENDEDOR
    response = await fetch('http://127.0.0.1:3000/api/vendedor/vendas', {
        method: 'get'
    });

    responseJson = await response.json();

    console.log(responseJson);

    var ctx = document.getElementById('vendedor_vendas').getContext('2d');
    var vendedor_vendas = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: responseJson.labels/*['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange']*/,
            datasets: [
                {
                    label: 'Realizado de Vendas',
                    data: responseJson.totalVendido/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(255, 0, 0, 1)',
                    borderColor: 'rgba(255, 0, 0, 1)',
                    borderWidth: 0
                },
                {
                    label: 'Meta de Venda',
                    data: responseJson.metaVenda/*[12, 19, 3, 5, 2, 3]*/,
                    backgroundColor: 'rgba(0, 255, 0, 1)',
                    borderColor: 'rgba(0, 255, 0, 1)',
                    borderWidth: 0
                }
            ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

}

fetchMixesFabricante();