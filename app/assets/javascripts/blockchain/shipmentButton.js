let shipping;
let shippingContract;
let contract
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

const createItemComponent = (item, shipmentId) => {
    let metaData = getMetaData(item);

    return `
    <div id="shipment-item-${item.id}" class="shipment-item border-${metaData.border} card mb-3" style="max-width: 18rem;">
        <div class="card-body">
         <h5 class="card-title">ITEM ${item.id}: ${item.name}</h5>
            <button id="record-action-${item.id}" class="record-action-btn btn btn-${metaData.color} col-md-12" data-action="${metaData.action}" data-id="${item.id}" data-shipmentId="${shipmentId}">${metaData.action}</button>
        </div>
        <div class="card-footer bg-transparent border-success">Status: ${metaData.stage}</div>
    </div>
    `
}

const getMetaData = (itemStatus) => {
    if (itemStatus.isDelivered == true) {
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

const getItems = async (shipment) => {
    const items = await Promise.all(
        Array.from({ length: shipment.itemsCount })
            .map((_, index) => call('getItemAtIndex', shipment.id, index).then((item) => {
                console.log(item)
                return createItem(item, shipment.id)
            })
            .catch(err => alert(err)))
    )

    return items
}

const createShipment = (companyName, orderId) => {
    send("createShipment", companyName, orderId)
        .then(result => {
            console.log(result)
        })
        .catch(err => alert(err) );
}

const getShipment = async (shipmentId) => {
    const result = await call("getShipment", shipmentId);
    const shipmentIdResult = result[0];

    if (shipmentIdResult == 0) {
        throw new Error("No shippment found at this id")
    }

    // syncStateAndDomWithResult(result)
    return shipmentObject(result);
}

const createItem = (item, shipmentId) => {
    let id = item[0]
    let name = item[1]
    let isCertified = item[2]
    let isWrapped = item[3]
    let isLoaded = item[4]
    let isCleared = item[5]
    let isDelivered = item[6]

    return {id, name, isCertified, isWrapped, isLoaded, isCleared, isDelivered,  recordAction: (action) => recordAction(shipmentId, id, action),}
}

const recordAction = (shipmentId, itemId, action) => {
    send('recordAction', shipmentId, itemId, action)
        .then(itemData => createItem(itemData, shipmentId))
        .catch(error => alert(error))
}

const shipmentObject = (result) => {
    console.log("shipmentObject", result)
    let id = result[0]
    let itemsCount = result[1]
    let companyName = result[2]
    let isDelivered = result[3]

    return {id, itemsCount, companyName, isDelivered}
}

const displayShipmentAndItems = (shipment, items) => {
    removeItems();
    let status = shipment.isDelivered == true ? "Delvered !" : "In Transit";
    $('#shipment-title').text(`TrackingNumber #${shipment.id} for ${shipment.companyName.toUpperCase()} has ${shipment.itemsCount} items and is ${status}`);
    $('#shipment-title-wrapper').show();

    console.log("items", items)

    items.forEach((item) => {
        $("#shipment-items").append(createItemComponent(item ,shipment.id));
    });
}

$(document).on('click', '#create-shipment-button', (ev) => {
    ev.preventDefault();
    removeItems();
    let companyName = $('#create-shipment-company-name').val();
    let orderId = $('#create-shipment-order-id').val();
    createShipment(companyName, orderId);
});

$(document).on('click', '#shippment-id-button', async (ev) => {
    ev.preventDefault();
    let shipmentId = 1 //$('#shipment-id').val();
    const shipment = await getShipment(shipmentId);
    const items = await getItems(shipment)
    displayShipmentAndItems(shipment, items);
    console.log(items)
});

$(document).on('click', '.record-action-btn', async (ev) => {
    let dataset = ev.target.dataset
    let action = dataset["action"].toLowerCase()
    let itemId = dataset["id"]
    let shipmentId = dataset["shipmentid"]

    console.log(dataset)

    await send("recordAction", shipmentId, itemId, action);
    const item = await call('getItem', shipmentId, itemId);
    const itemComponent = createItemComponent(createItem(item))
    $(`#shipment-item-${itemId}`).replaceWith(itemComponent)
});