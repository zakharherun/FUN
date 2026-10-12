# Backend

## Przeznaczenie

Backend to "zaplecze" aplikacji, czyli program działający na serwerze. Przyjmuje żądania z frontendu, sprawdza, czy dane są poprawne, a następnie zapisuje je w bazie lub pobiera z niej zadania. Dzięki temu frontend nie musi znać szczegółów działania bazy danych.

## Komunikacja

Backend udostępnia API, z którego korzysta frontend, i komunikuje się z bazą danych PostgreSQL. Schemat działania jest następujący:

1. Użytkownik wykonuje akcję na stronie (np. dodaje zadanie).
2. Frontend wysyła żądanie do API.
3. Backend przetwarza żądanie i zapisuje lub odczytuje dane w bazie PostgreSQL.
4. Backend odsyła odpowiedź, którą frontend pokazuje użytkownikowi.

## Planowane endpointy

| Metoda | Adres | Działanie |
|---|---|---|
| GET | `/api/tasks` | pobranie listy zadań |
| POST | `/api/tasks` | dodanie nowego zadania |
| PUT | `/api/tasks/{id}` | edycja zadania o podanym identyfikatorze |
| DELETE | `/api/tasks/{id}` | usunięcie zadania o podanym identyfikatorze |

## Proponowana struktura

```text
backend/
  Controllers/   obsługa żądań HTTP i endpointów
  Models/        opis danych, np. klasa zadania
  Services/      logika działania aplikacji
  Data/          połączenie z bazą danych
  Tests/         testy backendu
```
