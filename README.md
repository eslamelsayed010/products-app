# Products App

## Overview
This project is an iOS application developed as part of the **TRU iOS Technical Assessment**.  
It focuses on clean architecture, UIKit best practices, and handling real-world scenarios such as pagination, offline support, and error handling.

## Demo
Short demo video showcasing the main features:
- Products list (grid & list)
- Pagination
- Product details
- Offline handling

🎥 Demo Video: https://drive.google.com/file/d/1qexlRPhrqpiWNShuPzf6tHuLRJNrAiIk/view?usp=drive_link

---

## Features
- Products list fetched from remote API
- Grid / List layout switching
- Pagination (7 items per request)
- Product details screen
- Loading state indicator (SkeletonView)
- Error handling with user notification
- Offline support using cached data

---

## Architecture & Design
- **Architecture:** MVVM
- **UI Framework:** UIKit
- **Networking:** URLSession
- **Dependency Injection:** Protocol-oriented
- **State Handling:** Loading, success, error, and offline states
- **Caching:** Local persistence for offline usage

---

## Product Details Screen
- Dedicated view controller
- Stretchy header image during scroll
- Displays product image, title, category, price, and description

---

## API
https://fakestoreapi.com/products?limit=7

---

## Testing
- Basic **Unit tests**
- Focus on ViewModel logic and pagination behavior

---

## Bonus Implementations
- Skeleton loading
- Stretchy header
- Caching & offline handling
- Memory-conscious image loading

---

## Setup
1. Clone the repository
2. Open the `.xcodeproj`
3. Run on iOS Simulator (iOS 15+)

---

## Notes
The project emphasizes maintainable code, reusability, and scalability with a clean and minimal UX.

