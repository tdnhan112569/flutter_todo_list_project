# todo_list_project

Todo List Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This project using 
[Architecture BLOC](https://bloclibrary.dev/#/)
[Database NoSQL ObjectBox](https://objectbox.io)

This project is slipped by 3 layer (Presentation, Domain, Data)

- Presentation layer: init app data, theme, style, router, color
  Only one main screen is Dashboard
  Dashboard display todo data is filtered by Tab Option 
  Tab option have three options 
    - All: Display the complete and incomplete task
    - Complete: display only the complete task
    - Inomplete: display only the incomplete task
  
  CHANGE THE TAP OPTION BY TOUCHING ON BOTTOM BAR
  
  The presenter listen state change event from Domain layer for reloading and rerendering layout
  
- Domain layer: define structure of state, event state for handling business logic CRUD Todo

- Data Layer: define data source by define the logic to handle database (CRUD todo) to database
