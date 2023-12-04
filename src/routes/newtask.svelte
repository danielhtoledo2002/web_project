<script>
    import { db } from '$lib/session.js';
    
    const priorityOptions = ["Baja", "Mediana", "Alta", "Critica"];
    export let creating;
    export let id = "";

    function closeMenu() {
        creating = !creating;
    }

    async function createTask(){
        let name = document.getElementById("name").value;
        let description = document.getElementById("description").value;
        let dueDate = document.getElementById("dueDate").value;

        var date = new Date(dueDate);
        let due = date.toISOString();

        if (name === "" || description === "" || dueDate === "") {
            alert("Por favor llene todos los campos");
            return;
        }

        let priority = document.getElementById("priority").value;

        await db.query('CREATE task SET name = $name, description = $description, due_date = $dueDate, completed = false, task_list = $task_list', {
            name: name,
            description: description,
            dueDate: due,
            task_list: id
        });
        
        window.location.href = '/lista/' + id;
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

<div class="w-full">
    <div class="flex flex-col justify-between mx-auto w-1/3 my-10 bg-white p-6 rounded-lg shadow-inner ">
        <div class="flex justify-between">
            <h1 class="text-2xl font-bold mb-6">Crear Tarea</h1>
            <button class="close-button pl-6 h-10" on:click={closeMenu}>
            <i class="fa-solid fa-times"></i>
            </button>
        </div>
        <div class="mb-4 flex flex-row justify-start">
            <label for="name" class="block text-gray-700 font-bold mb-2 mr-2">Nombre:</label>
            <input type="text" id="name" class="border-2 rounded-lg border-[#6bbce3]" />
        </div>

        <div class="mb-4 flex justify-start">
            <label for="description" class="block text-gray-700 font-bold mb-2 mr-2">Descripción:</label>
            <textarea id="description" class="border-2 rounded-lg border-[#6bbce3] border-1 "></textarea>
        </div>

        <div class="mb-4 flex justify-start">
            <label for="dueDate" class="block text-gray-700 font-bold mb-2 mr-2">Fecha de Entrega:</label>
            <input type="datetime-local" id="dueDate" class="input-field" />
        </div>

        <div class="mb-4 flex justify-start">
            <label for="priority" class="block text-gray-700 font-bold mb-2 mr-2">Prioridad:</label>
            <select id="priority" class="input-field">
            {#each priorityOptions as option (option)}
            <option value={option}>{option}</option>
            {/each}
            </select>
        </div>

        <button class="button" on:click={createTask}>Crear Tarea</button>
    </div>
</div>