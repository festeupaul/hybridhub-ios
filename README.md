# HybridHub iOS

HybridHub este o aplicație mobilă nativă dezvoltată în **SwiftUI**, concepută pentru gestionarea și rezervarea birourilor într-un mediu de lucru hibrid. Acest proiect reprezintă componenta de client mobil dintr-un ecosistem Full-Stack complet.

<img width="1582" height="970" alt="Screenshot 2026-03-01 at 01 00 18" src="https://github.com/user-attachments/assets/26b2e38f-067f-4010-8949-6c95973edcae" />


## Demo Aplicație

<p align="center">
  <img src="https://github.com/user-attachments/assets/14df27aa-fdf0-4bbb-b155-4b276bb14991" width="300" alt="HybridHub iOS Demo">
</p>

---

## Funcționalități Principale

* **Rezervări în Timp Real:** Interogare asincronă a bazei de date pentru afișarea birourilor disponibile și a facilităților aferente.
* **Validare Inteligentă:** Prevenirea dublei rezervări prin verificarea instantanee a disponibilității datelor direct din calendar.
* **Gestiunea Stării (Mentenanță):** Birourile inactive sunt blocate automat la nivel de UI (grayed out) pentru a preveni erorile de rezervare.
* **Interfață Modernă:** Design curat implementat 100% în SwiftUI, utilizând navigare Master-Detail și resurse externe încărcate eficient.

---

## Ecosistem și Arhitectură Full-Stack

Aplicația iOS este complet integrată cu un backend robust. Mai jos este prezentată arhitectura sistemului și serviciile cloud utilizate:

### 1. Baza de Date (PostgreSQL via Neon.tech)
Găzduiește tabelele relaționale pentru birouri și rezervări.

<img width="1294" height="703" alt="Screenshot 2026-03-01 at 01 52 57" src="https://github.com/user-attachments/assets/c2af9932-48e3-4609-abdf-0a3ba9028dab" />

### 2. Backend API (Node.js & Express via Render)
Procesează logica de business și oferă endpoint-uri RESTful pentru clientul iOS.

<img width="1467" height="765" alt="Screenshot 2026-03-01 at 02 16 09" src="https://github.com/user-attachments/assets/2b6bec8c-31ef-4e59-a3f4-e69b89da0386" />

### 3. Web Dashboard (Next.js via Vercel)
Interfața de administrare dedicată departamentului de HR pentru gestionarea spațiilor.
(https://hybridhub-web.vercel.app)

<img width="1104" height="718" alt="Screenshot 2026-03-01 at 01 51 26" src="https://github.com/user-attachments/assets/f794ba3b-35c9-4253-907a-7e8b7825b225" />

### 4. GET/POST request testing (via Postman)

<img width="1269" height="800" alt="Screenshot 2026-03-01 at 01 52 00" src="https://github.com/user-attachments/assets/d2dfe324-3185-4476-91a7-d194eb758fd4" />

---

## Tehnologii iOS Utilizate

* **UI Framework:** SwiftUI
* **Arhitectură:** MVVM (Model-View-ViewModel)
* **Networking:** `URLSession` pentru apeluri REST API (GET/POST)
* **Decodare:** `Codable` pentru parsarea structurilor JSON
* **Asincronism:** `AsyncImage` pentru afișarea imaginilor din surse externe (Unsplash)
