
# Frontend Application (React)

This directory contains the source code for the frontend application, built using **React**. The frontend provides a user interface for managing todo items, interacting with the backend API for data.

## Project Structure

- **`package.json`**: Manages dependencies such as React, Axios (for API requests), and build scripts.
- **`Dockerfile`**: Defines how the frontend is containerized.
- **`src/`**: The source code of the React application.
  - **`App.js`**: The main React component where the app's structure is defined.
  - **`AddTodo.js`**: Component responsible for adding new todo tasks.
  - **`TodoList.js`**: Component that displays a list of todo tasks fetched from the backend.
  - **`index.js`**: The entry point that renders the React app.
  - **`index.css`**: Styling for the application.
- **`public/`**: Contains static files like the `index.html` template used by React.

## Application Logic

The application follows a component-based architecture, where each component manages a specific part of the UI:
- **`App.js`**: This is the top-level component that organizes other components like `AddTodo` and `TodoList`.
- **`AddTodo.js`**: Provides a form for the user to input new tasks. Once submitted, it makes a POST request to the backend API.
- **`TodoList.js`**: Fetches todo items from the backend using Axios (or another HTTP client) and renders them in a list format.

## Key Features
- **React Components**: The app is divided into modular components that handle different parts of the UI and logic.
- **Axios for API Calls**: Axios is used to make HTTP requests to the backend API, allowing the frontend to perform CRUD operations.
- **Dockerized**: The frontend is containerized, ensuring consistent behavior across environments.
- **Responsive Design**: The frontend is built to work seamlessly across different screen sizes.

