import { Api } from "./lib/api.js";

(function addCategory() {
    const submit_button = document.getElementById('submit_new_category');

    submit_button.addEventListener('click', () => {
        const name = document.getElementById('category_name').value;
        const add_another = document.getElementById('category_add_another').checked;
        // Create the category
        createCategory(name);

        // Close the modal
        if (!add_another) {
            console.log("CLOSING MODAL");
            const newCategoryModal = document.getElementById('newCategoryModal');
            const modal = bootstrap.Modal.getInstance(newCategoryModal);
            modal.hide();
            const modalBackdrop = document.getElementsByClassName("modal-backdrop");
            for (let i of modalBackdrop) { 
                console.log(i)
                i.remove(); 
            }
        }
    })
}())

function createCategory(name) {
    const api = new Api();
    api.post('/categories', {"category_name": name}, updateDOM)
}

function updateDOM(data) {
    const category_buttons = document.getElementById('category_buttons');
    const empty_notice = document.getElementById('no_category_notice');

    const new_button = `<button type="button" class="btn btn-outline-danger" data-key="${data.category_apikey}">${data.name}</button>`
    category_buttons.innerHTML = empty_notice ? new_button : category_buttons.innerHTML + new_button
}