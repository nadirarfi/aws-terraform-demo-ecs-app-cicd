import React, { useState } from 'react';

function AddTodo({ addTodo }) {
  const [title, setTitle] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    addTodo({ title });
    setTitle('');
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        value={title}
        onChange={(e) => setTitle(e.target.value)}
        placeholder="Add todo"
      />
      <button type="submit">Add</button>
    </form>
  );
}

export default AddTodo;