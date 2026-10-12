# Task Manager

## O projekcie

Task Manager to webowa aplikacja do zarządzania zadaniami. Umożliwia zapisywanie rzeczy do zrobienia, śledzenie postępu ich realizacji oraz szybkie odnajdywanie potrzebnych pozycji. Aplikacja działa w przeglądarce, więc użytkownik nie musi niczego instalować na swoim komputerze.

## Cel

Projekt powstaje po to, by w praktyce poznać proces tworzenia kompletnej aplikacji webowej: od interfejsu użytkownika, przez serwer i API, po bazę danych. Jest także okazją do przećwiczenia pracy zespołowej z Git i GitHub, w tym korzystania z osobnych branchy, pull requestów, code review oraz automatycznej weryfikacji kodu w pipeline.

## Funkcje

- tworzenie nowych zadań,
- edytowanie istniejących zadań,
- usuwanie zadań,
- zmiana statusu (np. do zrobienia, w trakcie, zrobione),
- wyszukiwanie zadań po nazwie,
- filtrowanie zadań według statusu.

## Stos technologiczny

| Warstwa | Technologia |
|---|---|
| Frontend | HTML, CSS, JavaScript |
| Backend | C# (REST API) |
| Baza danych | PostgreSQL |
| Kontrola wersji | Git i GitHub |
| CI | GitHub Actions |

## Struktura repozytorium

```text
.github/workflows/   # pipeline CI (GitHub Actions)
frontend/            # interfejs użytkownika (css, js, index.html)
backend/             # API i logika aplikacji (planowane)
task-manager/        # katalog projektu aplikacji
database/            # skrypty i schemat bazy danych (planowane)
docs/                # dodatkowa dokumentacja (planowane)
tests/               # testy (planowane)
```

## Postęp prac

- [x] Założenie repozytorium
- [x] Zabezpieczenie gałęzi `main`
- [x] Dodanie workflow GitHub Actions
- [x] Przygotowanie dokumentacji
- [ ] Stworzenie frontendu
- [ ] Zbudowanie API
- [ ] Podłączenie bazy danych

## Uruchamianie

Instrukcja uruchomienia pojawi się, gdy projekt będzie gotowy do pierwszego startu.