window.addEventListener('message', (event) => {
    if (event.data.action === 'openDuty') {
        document.getElementById('blur').style.display = 'block';
        const container = document.getElementById('duty-container');
        container.classList.remove('hidden');
        setTimeout(() => container.classList.add('active'), 50);
    } else if (event.data.action === 'askCallsign') {
        document.getElementById('duty-container').classList.add('hidden');
        const popup = document.getElementById('callsign-popup');
        popup.classList.remove('hidden');
        popup.dataset.role = event.data.role;
    }
});

document.getElementById('police').addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/selectRole`, {
        method: 'POST',
        body: JSON.stringify({ role: 'Police' })
    });
});

document.getElementById('fire').addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/selectRole`, {
        method: 'POST',
        body: JSON.stringify({ role: 'Fire' })
    });
});

document.getElementById('ambulance').addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/selectRole`, {
        method: 'POST',
        body: JSON.stringify({ role: 'Ambulance' })
    });
});

document.getElementById('close').addEventListener('click', () => {
    document.getElementById('blur').style.display = 'none';
    document.getElementById('duty-container').classList.remove('active');
    fetch(`https://${GetParentResourceName()}/close`, { method: 'POST' });
});

document.getElementById('submit-callsign').addEventListener('click', () => {
    const callsign = document.getElementById('callsign-input').value;
    const role = document.getElementById('callsign-popup').dataset.role;
    document.getElementById('callsign-popup').classList.add('hidden');
    document.getElementById('blur').style.display = 'none';
    fetch(`https://${GetParentResourceName()}/setCallsign`, {
        method: 'POST',
        body: JSON.stringify({ role: role, callsign: callsign })
    });
});
