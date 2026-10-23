"use strict";

// Prosty testowy serwer API (bez zewnętrznych bibliotek), tylko do prac nad frontendem.
// Działa zgodnie z kontraktem z materiałów (dzień 3):
//   GET /api/tasks, GET /api/tasks/:id, POST /api/tasks, PUT /api/tasks/:id, DELETE /api/tasks/:id
// Dane są w pamięci (znikają po zatrzymaniu serwera). Ten sam serwer pokazuje też stronę z katalogu frontend/.
//
// Uruchomienie:  node tools/mock-api/server.js   a potem otwórz  http://localhost:5000
// Prawdziwy backend (C# + PostgreSQL) ma zastąpić ten plik, frontend zmienia tylko API_URL.

const http = require("http");
const fs = require("fs");
const path = require("path");

const PORT = Number(process.env.PORT) || 5000;
const FRONTEND_DIR = path.resolve(__dirname, "..", "..", "frontend");
const STATUSES = ["new", "in_progress", "done"];

const seed = JSON.parse(fs.readFileSync(path.join(FRONTEND_DIR, "data", "tasks.json"), "utf8"));
let tasks = seed.map((task) => ({ ...task }));
let nextId = Math.max(0, ...tasks.map((task) => task.id)) + 1;

const MIME = {
  ".html": "text/html; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".json": "application/json; charset=utf-8",
  ".png": "image/png",
  ".svg": "image/svg+xml",
};

function send(res, status, body) {
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
  };
  if (body === undefined) {
    res.writeHead(status, headers);
    res.end();
    return;
  }
  headers["Content-Type"] = "application/json; charset=utf-8";
  res.writeHead(status, headers);
  res.end(JSON.stringify(body));
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    let raw = "";
    req.on("data", (chunk) => {
      raw += chunk;
      if (raw.length > 1e6) {
        req.destroy();
        reject(new Error("too large"));
      }
    });
    req.on("end", () => {
      try {
        resolve(raw ? JSON.parse(raw) : {});
      } catch {
        reject(new Error("bad json"));
      }
    });
  });
}

function validate(data, partial) {
  if (!partial || "title" in data) {
    if (typeof data.title !== "string" || data.title.trim() === "") {
      return "Tytuł jest wymagany.";
    }
    if (data.title.trim().length > 200) {
      return "Tytuł może mieć maksymalnie 200 znaków.";
    }
  }
  if ("status" in data && !STATUSES.includes(data.status)) {
    return "Nieprawidłowy status zadania.";
  }
  if ("description" in data && data.description != null && typeof data.description !== "string") {
    return "Opis musi być tekstem.";
  }
  return null;
}

async function handleApi(req, res, url) {
  const match = url.pathname.match(/^\/api\/tasks(?:\/(\d+))?$/);
  if (!match) {
    return send(res, 404, { error: "Nie znaleziono adresu." });
  }
  const id = match[1] ? Number(match[1]) : null;
  const task = id === null ? null : tasks.find((item) => item.id === id);

  if (req.method === "GET" && id === null) {
    return send(res, 200, tasks);
  }
  if (req.method === "GET") {
    return task ? send(res, 200, task) : send(res, 404, { error: "Nie znaleziono zadania." });
  }
  if (req.method === "POST" && id === null) {
    let data;
    try {
      data = await readBody(req);
    } catch {
      return send(res, 400, { error: "Niepoprawny format danych." });
    }
    const problem = validate(data, false);
    if (problem) {
      return send(res, 400, { error: problem });
    }
    const created = {
      id: nextId++,
      title: data.title.trim(),
      description: data.description ? String(data.description).trim() || null : null,
      status: data.status || "new",
      author: "admin",
      created_at: new Date().toISOString(),
    };
    tasks.push(created);
    return send(res, 201, created);
  }
  if (req.method === "PUT" && id !== null) {
    if (!task) {
      return send(res, 404, { error: "Nie znaleziono zadania." });
    }
    let data;
    try {
      data = await readBody(req);
    } catch {
      return send(res, 400, { error: "Niepoprawny format danych." });
    }
    const problem = validate(data, true);
    if (problem) {
      return send(res, 400, { error: problem });
    }
    if ("title" in data) {
      task.title = data.title.trim();
    }
    if ("description" in data) {
      task.description = data.description ? String(data.description).trim() || null : null;
    }
    if ("status" in data) {
      task.status = data.status;
    }
    return send(res, 200, task);
  }
  if (req.method === "DELETE" && id !== null) {
    if (!task) {
      return send(res, 404, { error: "Nie znaleziono zadania." });
    }
    tasks = tasks.filter((item) => item.id !== id);
    return send(res, 204);
  }
  return send(res, 405, { error: "Metoda niedozwolona." });
}

function serveStatic(req, res, url) {
  const relative = decodeURIComponent(url.pathname === "/" ? "/index.html" : url.pathname);
  const file = path.resolve(FRONTEND_DIR, "." + relative);
  if (file !== FRONTEND_DIR && !file.startsWith(FRONTEND_DIR + path.sep)) {
    res.writeHead(403);
    res.end("Forbidden");
    return;
  }
  fs.readFile(file, (error, content) => {
    if (error) {
      res.writeHead(404, { "Content-Type": "text/plain; charset=utf-8" });
      res.end("Nie znaleziono pliku.");
      return;
    }
    res.writeHead(200, { "Content-Type": MIME[path.extname(file)] || "application/octet-stream" });
    res.end(content);
  });
}

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${req.headers.host}`);
  if (req.method === "OPTIONS") {
    return send(res, 204);
  }
  if (url.pathname.startsWith("/api/")) {
    return handleApi(req, res, url).catch((error) => {
      console.error(error);
      send(res, 500, { error: "Błąd serwera." });
    });
  }
  return serveStatic(req, res, url);
});

server.listen(PORT, () => {
  console.log(`Testowe API: http://localhost:${PORT}/api/tasks`);
  console.log(`Aplikacja:   http://localhost:${PORT}/`);
});
