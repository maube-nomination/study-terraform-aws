import fetch from 'node-fetch';


export async function handler(event, context, callback) {
    let response = await fetch('https://api.exchangerate.host/latest')
    let responseJson = await response.json()
    console.log(responseJson);
}

exports.handler = handler;

// uncomment to test it
// handler()





