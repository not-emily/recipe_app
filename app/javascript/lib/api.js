
export class Api {
    // This method shouldn't be accessed outside of this file
    #makeRequest(endpoint, method, body, result_action) {
        const SERVER_BASE_URL = 'http://localhost:3000'

        var xhr = new XMLHttpRequest(); 
        xhr.open(method, SERVER_BASE_URL + endpoint);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').getAttribute('content'))
        xhr.send(JSON.stringify(body));

        xhr.onload = function (e) {
            if (xhr.status != 200) {
                return {error: `Error: ${e}`}
            }
        };

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) { //wait for the status to be complete       
                result_action(JSON.parse(xhr.response)); //update function
            }
        }
        // return xhr;
    };

    get(endpoint, result_action) {
        return this.#makeRequest(endpoint, 'GET', result_action)
    }

    post(endpoint, body, result_action) {
        return this.#makeRequest(endpoint, 'POST', body, result_action)
    }

    put(endpoint, body, result_action) {
        return this.#makeRequest(endpoint, 'PUT', body, result_action)
    }

    del(endpoint, result_action) {
        return this.#makeRequest(endpoint, 'DELETE', result_action)
    }
}