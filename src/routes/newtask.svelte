<script>
    import { db } from '$lib/session.js';
    
    const priorityOptions = ["Baja", "Mediana", "Alta", "Critica"];
    export let creating;

    function closeMenu() {
        creating = !creating;
    }
    function createTask(){
        console.log("sirve")
    }
</script>
    
<style>
.button {
    background-color: #89cff3;
    color: #000;
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 0.25rem;
    cursor: pointer;
    transition: background-color 0.3s;
}

.button:hover {
    background-color: #6bbce3; 
}

.close-button {
    background-color: #6bbce3; 
    color: #fff;
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 0.25rem;
    cursor: pointer;
    transition: background-color 0.3s;
}

.close-button:hover {
    background-color: #00A9FF; 
}
</style>

<div class="max-w-lg mx-auto my-10 bg-white p-6 rounded-lg shadow-inner">
<div class="flex items-start">
    <h1 class="text-2xl font-bold mb-6">Crear Tarea</h1>
    <button class="close-button pl-6" on:click={closeMenu}>
    <i class="fa-solid fa-times"></i>
    </button>
</div>
<div class="mb-4">
    <label for="name" class="block text-gray-700 font-bold mb-2">Nombre de la tarea:</label>
    <input type="text" id="name" class="input-field" />
</div>

<div class="mb-4">
    <label for="description" class="block text-gray-700 font-bold mb-2">Descripción:</label>
    <textarea id="description" class="input-field"></textarea>
</div>

<div class="mb-4">
    <label for="dueDate" class="block text-gray-700 font-bold mb-2">Fecha de Entrega:</label>
    <input type="date" id="dueDate" class="input-field" />
</div>

<div class="mb-4">
    <label for="priority" class="block text-gray-700 font-bold mb-2">Prioridad:</label>
    <select id="priority" class="input-field">
    {#each priorityOptions as option (option)}
    <option value={option}>{option}</option>
    {/each}
    </select>
</div>

<button class="button" on:click={createTask}>Crear Tarea</button>
</div>