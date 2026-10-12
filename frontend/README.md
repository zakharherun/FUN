# Frontend

## Rola w projekcie

Frontend to część aplikacji, którą użytkownik widzi i z którą pracuje na co dzień. Odpowiada za wyświetlanie listy zadań, obsługę formularzy oraz komunikację z backendem. Sam nie przechowuje danych na stałe, tylko wysyła do API prośby o ich pobranie lub zapisanie.

## Planowane widoki

- lista zadań z wyszukiwaniem i filtrowaniem,
- formularz dodawania nowego zadania,
- formularz edycji zadania,
- komunikaty informujące o powodzeniu lub błędzie operacji.

## Technologie

- HTML do budowy struktury stron,
- CSS do stylowania i układu elementów,
- JavaScript do obsługi kliknięć, formularzy i zapytań do API.

## Założenia dotyczące wyglądu i obsługi

- prosty, przejrzysty układ z dużą ilością wolnej przestrzeni,
- statusy zadań wyróżnione kolorami, aby były widoczne na pierwszy rzut oka,
- przyciski edycji i usuwania przy każdym zadaniu,
- pole wyszukiwania umieszczone nad listą,
- układ responsywny, dopasowany do telefonów i małych ekranów,
- potwierdzenie przed usunięciem zadania.

## Planowana struktura katalogów

```text
frontend/
  css/          # arkusze stylów
  js/           # skrypty
  images/       # grafiki i ikony (planowane)
  index.html    # strona główna
```