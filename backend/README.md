# Backend

## Przeznaczenie

Backend to część aplikacji, która działa na serwerze. Odbiera prośby z frontendu, zapisuje zadania w bazie danych i pobiera je z powrotem. Użytkownik go nie widzi, ale bez niego zadania nie byłyby nigdzie zapisywane.

## Komunikacja z bazą danych

Backend udostępnia API i łączy się z bazą PostgreSQL. Frontend nie rozmawia z bazą bezpośrednio, tylko przez backend.

## Planowane endpointy API

- GET /api/tasks, pobranie listy zadań,
- POST /api/tasks, dodanie nowego zadania,
- PUT /api/tasks/{id}, zmiana zadania,
- DELETE /api/tasks/{id}, usunięcie zadania.

## Struktura projektu

```text
backend/
  Controllers/
  Models/
  Services/
  Data/
  Tests/
```

W `Controllers` będą endpointy, w `Models` opis zadania, w `Services` logika aplikacji, a w `Data` połączenie z bazą. W `Tests` będą testy.
