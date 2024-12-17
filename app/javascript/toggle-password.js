function togglePassword(pw_confirmation = false) {
    password = pw_confirmation ? document.getElementById('password_confirmation'): document.getElementById('password')
    show = pw_confirmation ? document.getElementById('show-pw-conf') : document.getElementById('show-pw');
    hide = pw_confirmation ? document.getElementById('hide-pw-conf') : document.getElementById('hide-pw');

    if (password.type === "password") {
        password.type = 'text';
        show.style.display = 'none';
        hide.style.display = 'inline';
    } else {
        password.type = 'password';
        show.style.display = 'inline';
        hide.style.display = 'none';
    }
}