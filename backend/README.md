# Backend

## Rola w projekcie

Backend to serwerowa część aplikacji. Odbiera zapytania z frontendu, weryfikuje poprawność danych, realizuje logikę aplikacji oraz zapisuje i odczytuje informacje z bazy danych. Dzięki temu frontend nie musi znać szczegółów działania bazy.

## Komunikacja z bazą danych

Backend łączy się z bazą PostgreSQL, w której przechowywane są zadania. Wszystkie operacje na danych (dodawanie, odczyt, zmiana, usuwanie) przechodzą przez warstwę dostępu do danych, a frontend korzysta wyłącznie z API.

## Planowane endpointy API

| Metoda | Adres | Działanie |
|---|---|---|
| GET | `/api/tasks` | pobranie listy zadań |
| POST | `/api/tasks` | utworzenie nowego zadania |
| PUT | `/api/tasks/{id}` | edycja zadania o podanym id |
| DELETE | `/api/tasks/{id}` | usunięcie zadania o podanym id |

Dane będą przesyłane w formacie JSON.

## Planowana struktura katalogów

```text
backend/
  Controllers/   # obsługa zapytań HTTP i endpointów
  Models/        # opis obiektów, np. zadania
  Services/      # logika aplikacji
  Data/          # dostęp do bazy danych
  Tests/         # testy
```