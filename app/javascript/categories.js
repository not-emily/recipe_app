import { Api } from "./lib/api.js";

(function init() {
    const submit_button = document.getElementById('submit_new_category');
    submit_button.addEventListener('click', () => handleNewCategory())

    const category_buttons = document.getElementById('category_buttons');
    category_buttons.addEventListener('click', event => toggleCategorySelection(event.target))
}())

function handleNewCategory() {
    const nameElement = document.getElementById('category_name');
    const name = nameElement.value;

    const add_another = document.getElementById('category_add_another').checked;
    // Create the category
    createCategory(name);

    // Close the modal
    if (add_another) {
        nameElement.value = "";
    } else {
        console.log("CLOSING MODAL");
        nameElement.value = "";
        const newCategoryModal = document.getElementById('newCategoryModal');
        const modal = bootstrap.Modal.getInstance(newCategoryModal);
        modal.hide();
        const modalBackdrop = document.getElementsByClassName("modal-backdrop");
        for (let i of modalBackdrop) { 
            console.log(i)
            i.remove(); 
        }
    }
}

function createCategory(name) {
    const api = new Api();
    api.post('/categories', {"category_name": name}, updateDOM)
}

function updateDOM(data) {
    const category_buttons = document.getElementById('category_buttons');
    const empty_notice = document.getElementById('no_category_notice');

    const new_button = `<button type="button" class="btn btn-outline-danger" data-key="${data.category_apikey}">${data.category_name}</button>`
    category_buttons.innerHTML = empty_notice ? new_button : category_buttons.innerHTML + new_button
}

function toggleCategorySelection(category_button) {
    const selected_categories = document.getElementById('selected-categories')
    if (category_button.classList.contains('selected-category')) {
        category_button.classList.remove('selected-category')
        const children = selected_categories.children;
        for (let child of children) {
            if (child.value == category_button.dataset.key) {
                selected_categories.removeChild(child);
            }
        }
    } else {
        category_button.classList.add('selected-category')
        selected_categories.innerHTML += `<input type="hidden" name="categories[]" value=${category_button.dataset.key}>`
    }
}