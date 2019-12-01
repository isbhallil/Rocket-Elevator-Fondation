let shipping;
let shippingContract;
let abi;
let items;
let shipment;
let state = {items, shipment}

$(document).ready(()=>{
    var httpProvider = new Web3.providers.HttpProvider("http://18.234.83.2:8000")
    web3 = new Web3(httpProvider);

    abi = [{ "constant": false, "inputs": [{ "name": "shipmentId", "type": "uint256" }, { "name": "_name", "type": "string" }], "name": "addItem", "outputs": [{ "name": "", "type": "uint256" }, { "name": "", "type": "string" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [{ "name": "companyName", "type": "string" }, { "name": "orderId", "type": "uint256" }], "name": "createShipment", "outputs": [{ "name": "", "type": "uint256" }, { "name": "", "type": "uint256" }, { "name": "", "type": "string" }, { "name": "", "type": "bool" }], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [{ "name": "shipmentId", "type": "uint256" }, { "name": "itemId", "type": "uint256" }, { "name": "action", "type": "string" }], "name": "recordAction", "outputs": [{ "name": "", "type": "uint256" }, { "name": "", "type": "string" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [{ "name": "shipmentsId", "type": "uint256" }, { "name": "itemId", "type": "uint256" }], "name": "getItem", "outputs": [{ "name": "", "type": "uint256" }, { "name": "", "type": "string" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [{ "name": "shipmentsId", "type": "uint256" }, { "name": "index", "type": "uint256" }], "name": "getItemAtIndex", "outputs": [{ "name": "", "type": "uint256" }, { "name": "", "type": "string" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }, { "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [{ "name": "shipmentsId", "type": "uint256" }], "name": "getShipment", "outputs": [{ "name": "", "type": "uint256" }, { "name": "", "type": "uint256" }, { "name": "", "type": "string" }, { "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [{ "name": "shipmentsId", "type": "uint256" }], "name": "isShipmentDelivered", "outputs": [{ "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }];
    shippingContract = new web3.eth.Contract(abi, '0xE1650DFED43DDaA7AFE7EF3E1166a7405b953c45')
    shipping = { from: "0xb8f40c2ee67be8496b452befbbf863a3f406f403" }

    state.items = new Map();
    state.shipment = new Map();
})

const send = (contractEndpoint, ...args) => {
    return new Promise(function (resolve, reject) {
        shippingContract.methods[contractEndpoint](...args).send(shipping, function (error, result) {
            if (error) {
                reject(error);
            }

            resolve(result);
        });
    })
}

const call = (contractEndpoint, ...args) => {
    return new Promise(function (resolve, reject) {
        shippingContract.methods[contractEndpoint](...args).call(shipping, function (error, result) {
            if (error) {
                reject(error);
            }

            resolve(result);
        });
    })
}

const revealTitle = (shipmentId, title, itemsCount, shipmentStatus) => {
    let status = shipmentStatus == true ? "delvered" : "in transit";
    $('#shipment-title').text(`TrackingNumber #${shipmentId} for ${title.toUpperCase()} has ${itemsCount} items and is ${status}`);
    $('#shipment-title-wrapper').show();
}

const appendItem = (itemId, itemName, itemStatus, shipmentId) => {
    var item = itemComponent(itemId, itemName, itemStatus, shipmentId);

    $("#shipment-items").append(item);
}

const itemComponent = (itemId, itemName, itemStatus, shipmentId) => {
    let metaData = getMetaData(itemStatus);

    return `
    <div id="shipment-item-${itemId}" class="shipment-item border-${metaData.border} card mb-3" style="max-width: 18rem;">
        <div class="card-body">
         <h5 class="card-title">ITEM ${itemId}: ${itemName}</h5>
            <button id="record-action-${itemId}" class="record-action-btn btn btn-${metaData.color} col-md-12" data-action="${metaData.action}" data-id="${itemId}" data-shipmentId="${shipmentId}">${metaData.action}</button>
        </div>
        <div class="card-footer bg-transparent border-success">Status: ${metaData.stage}</div>
    </div>
    `
}

const getMetaData = (itemStatus) => {
    if (itemStatus.isDelvered == true) {
        return {color:'success', stage: "delivered", action: "No Action Needed"}
    } else if (itemStatus.isCleared == true) {
        return {color: 'primary', stage: "cleared", action: "Deliver"}
    } else if (itemStatus.isLoaded == true) {
        return {color:'info', stage: 'in transit', action: "Clear"}
    } else if (itemStatus.isWrapped == true) {
        return {color: 'warning', stage: 'waiting for transit', action: "Load"}
    } else if (itemStatus.isCertified == true) {
        return {color: 'danger', stage: 'waiting for preparation', action: "Wrap"}
    } else {
        return {color:'black', stage: 'waiting for certification', action: "Certify"}
    }
}

const getNextAction = (action) => {
    if (action == 'certify'){
        return 'wrap'
    }
    else if (action == 'wrap'){
        return 'load'
    }
    else if (action == 'load'){
        return 'clear'
    }
    else if (action == 'clear'){
        return 'deliver'
    }
    else {
        return 'Ok'
    }
}

const removeItems = () => {
    state.items.clear();
    $(`.shipment-item`).remove()
}

const getItems = (result) => {
    shipmentId = result[0]
    itemsCount = result[1]
    companyName = result[2]

    for (let index = 0; index < itemsCount; index++) {
        call('getItemAtIndex', shipmentId, index)
            .then(result => {
                setItemState(result);
            })
            .catch(error => {
                alert(error);
            })
    }
}

const createShipment = (companyName, orderId) => {
    return call("createShipment", companyName, orderId)
}

const getShipment = (shipmentId) => {
    return call("getShipment", shipmentId)
}

const itemState = (result) => {
    let id = result[0]
    let name = result[1]
    let isCertified = result[2]
    let isWrapped = result[3]
    let isLoaded = result[4]
    let isCleared = result[5]
    let isDelivered = result[6]

    return {id, name, isCertified, isWrapped, isLoaded, isCleared, isDelivered}
}

const setItemState = (result) => {
    state.items.set(result[0], {
        ...itemState(result),
        recordAction,
    });
}

const recordAction = (action) => {
    console.log(this)
    call('recordAction', this.id, action)
        .then(result => {
            setItemState(result)
        })
        .catch(error => {
            alert(error)
        })
}

const shipmentState = (result) => {
    let id = result[0]
    let itemsCount = result[1]
    let companyName = result[2]
    let isDelivered = result[3]

    return {id, itemsCount, companyName, isDelivered}
}

const syncItemsWithState = () => {
    state.items.forEach(item => {
        console.log(item)
    });
}

const syncTitleWithState = () => {
    let shipment = state.shipment.get('current')
    let status = shipment.isDelivered == true ? "Delvered !" : "In Transit";
    $('#shipment-title').text(`TrackingNumber #${shipment.id} for ${shipment.companyName.toUpperCase()} has ${shipment.itemsCount} items and is ${status}`);
    $('#shipment-title-wrapper').show();
}

const syncStateAndDomWithResult = (result) => {
    removeItems();
    state.shipment.set('current', { ...shipmentState(result) });
    getItems(result);
    syncTitleWithState();
    syncItemsWithState();
}

$(document).on('click', '#create-shipment-button', (ev) => {
    ev.preventDefault();
    removeItems();
    let companyName = $('#create-shipment-company-name').val();
    let orderId = $('#create-shipment-order-id').val();
    console.log(companyName, orderId);
    createShipment(companyName, orderId)
        .then(result => syncStateAndDomWithResult(result) )
        .catch(err => alert(err) );
});

$(document).on('click', '#shippment-id-button', (ev) => {
    ev.preventDefault();
    removeItems();
    let shipmentId = $('#shipment-id').val();
    getShipment(shipmentId)
        .then(result => {
            if (result[0] == 0) {
                alert("No shippment found at this id")
            }
            else {
                syncStateAndDomWithResult(result)
            }
        })
        .catch(err => {
            alert(err);
        });
});

$(document).on('click', '.record-action-btn', (ev) => {
    let dataset = ev.target.dataset
    let action = dataset["action"].toLowerCase()
    let itemId = dataset["id"]
    let shipmentId = dataset["shipmentid"]

    console.log(dataset)

    shippingContract.methods.recordAction(shipmentId, itemId, action).send(shipping, function(err, res){
        if(err){
            alert(err)
        }
        else{
            shippingContract.methods.getItem(shipmentId, itemId).call(shipping, function(err, getItemRes){
                let id = getItemRes[0];
                let name = getItemRes[1];
                let status = {
                    isCertified: getItemRes[2],
                    isWrapped: getItemRes[3],
                    isLoaded: getItemRes[4],
                    isCleared: getItemRes[5],
                    isDeliered: getItemRes[6],
                }

                $(`#shipment-item-${itemId}`).replaceWith(itemComponent(id, name, status, shipmentId))
            })
        }
    })

    console.log(action, itemId, shipmentId)
});