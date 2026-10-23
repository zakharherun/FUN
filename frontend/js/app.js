"use strict";

// Adres backendu ASP.NET (profil http w launchSettings.json).
const API_URL = "http://localhost:5113/api/tasks";

// Dopóki nie ma logowania, nowe zadania zapisujemy jako użytkownik o id 1 (admin z insert-data.sql).
const CURRENT_USER_ID = 1;

const form = document.getElementById("task-form");
const formTitle = document.getElementById("form-title");
const titleInput = document.getElementById("title");
const descriptionInput = document.getElementById("description");
const statusSelect = document.getElementById("status");
const submitButton = document.getElementById("submit-button");
const cancelButton = document.getElementById("cancel-button");
const message = document.getElementById("message");

let tasks = [];
let editingId = null;

function showMessage(text, isError) {
  message.textContent = text;
  message.className = isError ? "message message-error" : "message message-success";
  message.hidden = false;
}

async function request(url, method, data) {
  let response;
  try {
    response = await fetch(url, {
      method: method,
      headers: { "Content-Type": "application/json" },
      body: data ? JSON.stringify(data) : undefined,
    });
  } catch (error) {
    throw new Error("Brak połączenia z serwerem. Sprawdź, czy API działa.");
  }

  if (response.status === 204) {
    return null;
  }

  const body = await response.json().catch(() => ({}));
  if (!response.ok) {
    throw new Error(errorMessage(response.status, body));
  }
  return body;
}

// Zamienia odpowiedź z błędem na tekst dla użytkownika.
function errorMessage(status, body) {
  // format z kontraktu API: { "error": "Tytuł jest wymagany." }
  if (body.error) {
    return body.error;
  }
  // format ASP.NET: { "errors": { "Title": ["Tytuł jest wymagany."] } }
  if (body.errors) {
    const first = Object.values(body.errors)[0];
    if (first && first.length > 0) {
      return first[0];
    }
  }
  if (status === 404) {
    return "Nie znaleziono zadania.";
  }
  return "Błąd serwera (" + status + ").";
}

function createButton(text, className, onClick) {
  const button = document.createElement("button");
  button.type = "button";
  button.textContent = text;
  button.className = "btn " + className;
  button.addEventListener("click", onClick);
  return button;
}

function createCard(task) {
  const card = document.createElement("li");
  card.className = "task";

  const title = document.createElement("h4");
  title.textContent = task.title;

  const description = document.createElement("p");
  if (task.description) {
    description.textContent = task.description;
  } else {
    description.textContent = "brak opisu";
    description.className = "empty";
  }

  const buttons = document.createElement("div");
  buttons.className = "task-buttons";
  buttons.append(
    createButton("Edytuj", "btn-edit", () => startEdit(task)),
    createButton("Usuń", "btn-delete", () => deleteTask(task))
  );

  card.append(title, description, buttons);
  return card;
}

function showTasks() {
  for (const status of ["new", "in_progress", "done"]) {
    const list = document.getElementById("list-" + status);
    const count = document.getElementById("count-" + status);

    const cards = [];
    for (const task of tasks) {
      if (task.status === status) {
        cards.push(createCard(task));
      }
    }

    list.replaceChildren(...cards);
    count.textContent = cards.length;
  }
}

async function loadTasks() {
  try {
    tasks = await request(API_URL, "GET");
    showTasks();
  } catch (error) {
    showMessage(error.message, true);
  }
}

function resetForm() {
  editingId = null;
  form.reset();
  titleInput.removeAttribute("aria-invalid");
  formTitle.textContent = "Nowe zadanie";
  submitButton.textContent = "Dodaj zadanie";
  cancelButton.hidden = true;
}

function startEdit(task) {
  message.hidden = true;
  editingId = task.id;
  titleInput.value = task.title;
  descriptionInput.value = task.description || "";
  statusSelect.value = task.status;
  formTitle.textContent = "Edytuj zadanie";
  submitButton.textContent = "Zapisz zmiany";
  cancelButton.hidden = false;
  titleInput.focus();
}

async function deleteTask(task) {
  message.hidden = true;
  if (!confirm("Na pewno usunąć zadanie?")) {
    return;
  }

  try {
    await request(API_URL + "/" + task.id, "DELETE");
    if (editingId === task.id) {
      resetForm();
    }
    showMessage("Usunięto zadanie.");
    await loadTasks();
  } catch (error) {
    showMessage(error.message, true);
  }
}

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  message.hidden = true;

  const task = {
    title: titleInput.value.trim(),
    description: descriptionInput.value.trim(),
    status: statusSelect.value,
  };

  let problem = "";
  if (task.title === "") {
    problem = "Tytuł jest wymagany.";
  } else if (task.title.length > 200) {
    problem = "Tytuł może mieć maksymalnie 200 znaków.";
  }
  if (problem) {
    titleInput.setAttribute("aria-invalid", "true");
    showMessage(problem, true);
    titleInput.focus();
    return;
  }

  try {
    if (editingId === null) {
      await request(API_URL, "POST", { ...task, userId: CURRENT_USER_ID });
      showMessage("Dodano zadanie.");
    } else {
      await request(API_URL + "/" + editingId, "PUT", task);
      showMessage("Zapisano zmiany.");
    }
    resetForm();
    await loadTasks();
  } catch (error) {
    showMessage(error.message, true);
  }
});

titleInput.addEventListener("input", () => {
  titleInput.removeAttribute("aria-invalid");
});

cancelButton.addEventListener("click", () => {
  message.hidden = true;
  resetForm();
});

loadTasks();
