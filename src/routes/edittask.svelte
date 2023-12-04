<script>
    import { db } from '$lib/session.js';
    
    export let id = "";
    export let descripcion = "";
    export let nombre = "";
    export let editing = false;

    const priorityOptions = ["Baja", "Mediana", "Alta", "Critica"];

    async function createTask(){
        let nombre = document.getElementById("name").value;
        let descripcion = document.getElementById("description").value;
        let dueDate = document.getElementById("dueDate").value;

        var date = new Date(dueDate);
        let due = date.toISOString();

        try {
          if (nombre !== "") {
            await db.merge(id, {
                name: nombre,
            });
          }

          if (descripcion !== "") {
            await db.merge(id, {
                description: descripcion,
            });
          }

         window.location.href = '/listas';
        } catch (err) {
            console.log(err);
            window.location.href = '/login';
        }
    }
    function closeMenu() {
        editing = !editing;
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
            <input type="text" id="name" placeholder={nombre} required class="border-2 rounded-lg border-[#6bbce3]" />
        </div>

        <div class="mb-4 flex justify-start">
            <label for="description" class="block text-gray-700 font-bold mb-2 mr-2">Descripción:</label>
            <textarea id="description" placeholder={descripcion} required class="border-2 rounded-lg border-[#6bbce3] border-1 "></textarea>
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