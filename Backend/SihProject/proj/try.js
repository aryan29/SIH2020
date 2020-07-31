const url = 'http://127.0.0.1:8000/api/admin/getPlottingData';
const fetch = require("node-fetch");
// post body data 
const data = {
    password: "letitbeanything"
};

// request options
const options = {
    method: 'POST',
    body: JSON.stringify(data),
    mode: 'no-cors',

    headers: {
        'Content-Type': 'application/json',
    }
}

fetch(url, options)
    .then(res => res.json())
    .then(res => console.log(res));