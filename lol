function setupGreeting() {
    const greeting = document.getElementById("greeting");
    const button = document.getElementById("name-button");
    const error = document.getElementById("name-error");
    const savedName = localStorage.getItem("userName");

    // Показываем сохранённое имя сразу при открытии страницы.
    if (savedName) {
        greeting.textContent = `Привет, ${savedName}!`;
        button.textContent = "Изменить имя";
    }

    function askName() {
        const name = prompt("Как тебя зовут?");

        // null означает «Отмена». trim() убирает пробелы по краям.
        if (name === null || name.trim() === "") {
            error.textContent = "Ты не указал имя. Нажми кнопку и попробуй ещё раз.";
            return;
        }

        const cleanName = name.trim();
        localStorage.setItem("userName", cleanName);
        greeting.textContent = `Привет, ${cleanName}!`;
        button.textContent = "Изменить имя";
        error.textContent = "";
    }

    // Передаём функцию без скобок: она запустится по нажатию.
    button.addEventListener("click", askName);
}


// 2. МЕНЮ-ГАМБУРГЕР
function setupMenu() {
    const menu = document.querySelector("header nav")
        || document.querySelector("nav");

    if (!menu) {
        return;
    }

    const button = document.createElement("button");
    button.type = "button";
    button.className = "menu-toggle";

    if (!menu.id) {
        menu.id = "portfolio-menu";
    }

    button.setAttribute("aria-controls", menu.id);
    menu.before(button);

    const mobileScreen = window.matchMedia("(max-width: 768px)");

    function updateMenu() {
        button.hidden = !mobileScreen.matches;
        menu.hidden = mobileScreen.matches;
        button.textContent = "☰ Меню";
        button.setAttribute("aria-expanded", "false");
    }

    button.addEventListener("click", function () {
        menu.hidden = !menu.hidden;
        button.textContent = menu.hidden ? "☰ Меню" : "✕ Закрыть";
        button.setAttribute("aria-expanded", String(!menu.hidden));
    });

    menu.addEventListener("click", function (event) {
        if (mobileScreen.matches && event.target.closest("a")) {
            updateMenu();
        }
    });

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape" && mobileScreen.matches && !menu.hidden) {
            updateMenu();
            button.focus();
        }
    });

    mobileScreen.addEventListener("change", updateMenu);
    updateMenu();
}


// 3. КНОПКА «НАВЕРХ»
function setupScrollTop() {
    const button = document.createElement("button");
    button.type = "button";
    button.className = "back-to-top";
    button.textContent = "↑ Наверх";
    button.setAttribute("aria-label", "Вернуться наверх");
    document.body.appendChild(button);

    function updateButton() {
        button.hidden = window.scrollY < 300;
    }

    window.addEventListener("scroll", updateButton);

    button.addEventListener("click", function () {
        const reducedMotion = window.matchMedia(
            "(prefers-reduced-motion: reduce)"
        ).matches;

        window.scrollTo({
            top: 0,
            behavior: reducedMotion ? "instant" : "smooth"
        });
    });

    updateButton();
}


// Файл подключён с defer: HTML уже готов.
setupMenu();
setupScrollTop();
setupGreeting();
