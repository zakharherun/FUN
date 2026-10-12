# Frontend

## Przeznaczenie

Frontend to ta część aplikacji, którą widzi i obsługuje użytkownik. Odpowiada za wyświetlanie listy zadań, formularze do dodawania i edycji oraz za reagowanie na kliknięcia. Dane o zadaniach nie są przechowywane w przeglądarce na stałe, tylko pobierane z backendu i tam zapisywane.

## Planowane widoki

- lista zadań z możliwością filtrowania i wyszukiwania,
- formularz dodawania nowego zadania,
- formularz edycji zadania,
- potwierdzenie przed usunięciem zadania.

## Technologie

- HTML do zbudowania struktury stron,
- CSS do nadania wyglądu,
- JavaScript do obsługi interakcji i komunikacji z API.

## Proponowana struktura

```text
frontend/
  css/          pliki ze stylami
  js/           skrypty JavaScript
  images/       grafiki i ikony
  index.html    strona główna
```

## Pomysły na wygląd i obsługę

- prosty, czytelny układ, w którym zadania są widoczne od razu po wejściu na stronę,
- statusy zadań oznaczone różnymi kolorami, żeby łatwo je odróżnić,
- przyciski edycji i usuwania przy każdym zadaniu,
- dostosowanie strony do telefonów i komputerów (układ responsywny),
- komunikaty o błędach, np. gdy użytkownik zostawi puste pole tytułu zadania.
