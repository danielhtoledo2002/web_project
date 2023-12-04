<script>
    import { db } from '$lib/session.js';
    
    let task = {
        name: "",
        description: "",
        dueDate: "",
        priority: "",
        assignedList: "",
    };
    
    const priorityOptions = ["Low", "Medium", "High", "Critical"];
    const listOptions = ["List 1", "List 2", "List 3"]; // Agrega tus propias opciones de lista

    </script>
    
    <style>
    /* Agrega tus estilos aquí */
    .form-container {
        max-width: 32rem;
        margin: 10rem auto;
        background-color: #fff;
        padding: 1.5rem;
        border-radius: 0.5rem;
        box-shadow: 0 0 1rem rgba(0, 0, 0, 0.1);
    }
    
    .form-container h1 {
        font-size: 1.5rem;
        font-weight: bold;
        margin-bottom: 1.5rem;
    }
    
    .form-container label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: bold;
    }
    
    .form-container input,
    .form-container textarea,
    .form-container select {
        width: 100%;
        border: 1px solid #ccc;
        border-radius: 0.25rem;
        padding: 0.5rem;
        margin-bottom: 1rem;
    }
    
    .form-container button {
        background-color: #89cff3;
        color: #000;
        padding: 0.5rem 1rem;
        border: none;
        border-radius: 0.25rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    .form-container button:hover {
        background-color: #ccc;
    }
    </style>
    
    <main class="form-container">
    <div>
        <div class="flex items-start">
        <h1 class="text-2xl font-bold mb-6">Crear Tarea</h1>
        <button class="ml-auto" on:click={closeMenu}>
            <i class="fa-solid fa-times"></i>
        </button>
        </div>
        <div class="mb-4">
        <label for="name" class="block text-gray-700 font-bold mb-2">Nombre de la tarea:</label>
        <input type="text" id="name" bind:value={task.name} class="input-field" />
        </div>
    
        <div class="mb-4">
        <label for="description" class="block text-gray-700 font-bold mb-2">Descripción:</label>
        <textarea id="description" bind:value={task.description} class="input-field"></textarea>
        </div>
    
        <div class="mb-4">
        <label for="dueDate" class="block text-gray-700 font-bold mb-2">Fecha de Entrega:</label>
        <input type="date" id="dueDate" bind:value={task.dueDate} class="input-field" />
        </div>
    
        <div class="mb-4">
        <label for="priority" class="block text-gray-700 font-bold mb-2">Prioridad:</label>
        <select id="priority" bind:value={task.priority} class="input-field">
            {#each priorityOptions as option (option)}
            <option value={option}>{option}</option>
            {/each}
        </select>
        </div>
    
        <div class="mb-4">
        <label for="assignedList" class="block text-gray-700 font-bold mb-2">Lista Asignada:</label>
        <select id="assignedList" bind:value={task.assignedList} class="input-field">
            {#each listOptions as option (option)}
            <option value={option}>{option}</option>
            {/each}
        </select>
        </div>
    
        <button class="button" on:click={createTask()}>Crear Tarea</button>
    </div>
    </main>
    