import React, { useState, useEffect } from "react";
import AddTodo from "./AddTodo";
import TodoList from "./TodoList";

// Use the backend URL from environment variable or fallback to localhost for development
// const backendUrl = process.env.REACT_APP_BACKEND_DOMAIN_NAME || "http://localhost:8080";
const backendUrl = "";

function App() {
  const [todos, setTodos] = useState([]);
  console.log(backendUrl);
  // Fetch todos from the backend
  useEffect(() => {
    fetch(`${backendUrl}/api/todos/`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json", // Ensure you're accepting JSON response
      },
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Error fetching data: ${response.statusText}`);
        }
        return response.json();
      })
      .then((data) => {
        console.log("Fetched data:", data);
        setTodos(data);
      })
      .catch((error) => console.error("Error fetching data:", error));
  }, []);

  // Add new todo to the backend
  const addTodo = async (todo) => {
    // Basic validation for the todo object
    if (!todo || !todo.title) {
      console.error("Invalid todo item, title is required");
      return;
    }

    try {
      // Make the POST request using async/await
      const response = await fetch(`${backendUrl}/api/todos/`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
        body: JSON.stringify(todo), // Send the todo object as JSON
      });

      console.log(todo)

      // Check if response is ok (status 2xx)
      if (!response.ok) {
        const errorData = await response.json(); // Get error details
        throw new Error(
          `Error adding todo: ${errorData.message} (${response.status})`
        );
      }

      const data = await response.json(); // Parse the JSON response
      // Successfully added, update the todos state
      setTodos((prevTodos) => [...prevTodos, data]);
    } catch (error) {
      // Handle errors properly, log the error, and provide feedback
      console.error("Error adding todo:", error);
      alert(`Failed to add todo: ${error.message}`); // Optional user feedback
    }
  };

  return (
    <div className="container">
      <h1>Todo List</h1>
      <p>This is just a TodoList demo deployed with Django/React on AWS</p>
      <AddTodo addTodo={addTodo} />
      <TodoList todos={todos} />
      <footer>Demo created by Nadir Arfi's ChatGPT</footer>
    </div>
  );
}

export default App;
