# Testowe API (mock)

Prosty serwer do prac nad frontendem, dopóki nie ma prawdziwego backendu (C# + PostgreSQL).
Nie wymaga instalowania żadnych bibliotek, potrzebny jest tylko Node.js.

## Uruchomienie

```
node tools/mock-api/server.js
```

Potem otwórz w przeglądarce: http://localhost:5000

Serwer działa zgodnie z kontraktem API:

| Metoda | Adres | Odpowiedź |
|--------|-------|-----------|
| GET | /api/tasks | 200 + lista zadań |
| GET | /api/tasks/:id | 200 lub 404 |
| POST | /api/tasks | 201 lub 400 |
| PUT | /api/tasks/:id | 200, 400 lub 404 |
| DELETE | /api/tasks/:id | 204 lub 404 |

Błędy mają postać `{ "error": "..." }`.

Dane startowe są w `frontend/data/tasks.json` (te same 7 zadań co w `insert-data.sql`).
Zmiany są tylko w pamięci, po zatrzymaniu serwera (Ctrl+C) dane wracają do stanu początkowego.

## Przejście na prawdziwy backend

W `frontend/js/app.js` zmienia się tylko jedna stała `API_URL`.
Backend musi zwracać nagłówki CORS, jeśli strona jest otwierana z innego adresu niż API.
