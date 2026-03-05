# HybridHub iOS

HybridHub is a native mobile application developed in **SwiftUI**, designed for managing and booking desks in a hybrid work environment. This project represents the mobile client component of a complete Full-Stack ecosystem.

<img width="1582" height="970" alt="Screenshot 2026-03-01 at 01 00 18" src="https://github.com/user-attachments/assets/26b2e38f-067f-4010-8949-6c95973edcae" />

## App Demo

<p align="center">
  <img src="https://github.com/user-attachments/assets/14df27aa-fdf0-4bbb-b155-4b276bb14991" width="300" alt="HybridHub iOS Demo">
</p>

---

## Key Features

* **Real-Time Booking:** Asynchronous database querying to display available desks and their associated amenities.
* **Smart Validation:** Prevention of double-booking through instant availability checks directly from the calendar UI.
* **State Management (Maintenance):** Inactive desks are automatically blocked at the UI level (grayed out) to prevent booking errors.
* **Modern Interface:** Clean, responsive design implemented 100% in SwiftUI, utilizing Master-Detail navigation and efficiently loading external resources.

---

## iOS Tech Stack

* **UI Framework:** SwiftUI
* **Architecture:** MVVM (Model-View-ViewModel)
* **Networking:** `URLSession` for REST API calls (GET/POST)
* **Decoding:** `Codable` for parsing JSON structures
* **Asynchrony:** `AsyncImage` for displaying images from external sources (Unsplash)

---

## Full-Stack Ecosystem and Architecture

The iOS application is fully integrated with a robust backend. Below is the system architecture and the cloud services utilized:

### 1. Database (PostgreSQL via Neon.tech)
Hosts the relational tables for desks, users, and bookings.

<img width="1294" height="703" alt="Screenshot 2026-03-01 at 01 52 57" src="https://github.com/user-attachments/assets/c2af9932-48e3-4609-abdf-0a3ba9028dab" />

### 2. Backend API (Node.js & Express via Render)
Processes business logic and provides RESTful endpoints for the iOS client.

<img width="1467" height="765" alt="Screenshot 2026-03-01 at 02 16 09" src="https://github.com/user-attachments/assets/2b6bec8c-31ef-4e59-a3f4-e69b89da0386" />

### 3. Web Dashboard (Next.js via Vercel)
Dedicated administration interface for the HR department to manage office spaces and monitor bookings.
**Live Link:** [https://hybridhub-web.vercel.app](https://hybridhub-web.vercel.app)

<img width="1104" height="718" alt="Screenshot 2026-03-01 at 01 51 26" src="https://github.com/user-attachments/assets/f794ba3b-35c9-4253-907a-7e8b7825b225" />

### 4. API Testing (via Postman)
Comprehensive testing environment for GET/POST requests ensuring reliable client-server communication.

<img width="1269" height="800" alt="Screenshot 2026-03-01 at 01 52 00" src="https://github.com/user-attachments/assets/d2dfe324-3185-4476-91a7-d194eb758fd4" />

---

## How to Run Locally

Follow these steps to build and run the HybridHub iOS application on your local machine.

### Prerequisites
* **macOS:** You must have a Mac running a compatible version of macOS.
* **Xcode:** Install the latest version of Xcode from the Mac App Store.
* **iOS Simulator/Device:** An iPhone simulator (included with Xcode) or a physical iPhone.

### Setup Instructions

1. **Clone the Repository**
   Open your terminal and run the following command to clone the project to your local machine:
   ```bash
   git clone [https://github.com/festeupaul/hybridhub-ios.git](https://github.com/festeupaul/hybridhub-ios.git)
