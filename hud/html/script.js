window.addEventListener('message', function(event) {
    let data = event.data;

    switch(data.action) {
        case "init":
            applyConfig(data.config);
            break;
        case "setVisibility":
            document.getElementById('hud-container').style.display = data.toggle ? 'flex' : 'none';
            break;
        case "updateMoney":
            updateValue('cash-amount', 'cash-container', data.value);
            break;
        case "updateBank":
            updateValue('bank-amount', 'bank-container', data.value);
            break;
        case "updateBlackMoney":
            updateValue('black-amount', 'black-container', data.value);
            break;
        case "updateAll":
            updateValue('cash-amount', 'cash-container', data.cash);
            updateValue('bank-amount', 'bank-container', data.bank);
            updateValue('black-amount', 'black-container', data.blackMoney);
            document.getElementById('server-id').innerText = data.serverId;
            document.getElementById('id-container').style.display = 'block';
            break;
    }
});

function applyConfig(config) {
    const container = document.getElementById('hud-container');
    
    // Apply sizes and fonts
    container.style.fontSize = config.TextSettings.fontSize;
    container.style.fontFamily = config.TextSettings.fontFamily;
    container.style.fontWeight = config.TextSettings.fontWeight;

    // Apply colors to the row wrappers so the $ symbol inherits the same color
    document.getElementById('bank-container').style.color = config.Colors.bank;
    document.getElementById('cash-container').style.color = config.Colors.cash;
    document.getElementById('black-container').style.color = config.Colors.blackMoney;
    document.getElementById('id-container').style.color = config.Colors.serverId;
}

function updateValue(elementId, containerId, value) {
    // Only display dirty money row if the player actually has dirty money
    if (containerId === 'black-container' && value <= 0) {
        document.getElementById(containerId).style.display = 'none';
        return;
    }

    document.getElementById(elementId).innerText = value.toLocaleString();
    document.getElementById(containerId).style.display = 'block';
}