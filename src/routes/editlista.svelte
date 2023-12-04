<script>
    import { db } from '$lib/session.js';

    export let id = "";
    export let descripcion = "";
    export let nombre = "";
    export let editing = false;

    async function createList() {
        let nombre = document.getElementById('nombre-tarea').value;
        let descripcion = document.getElementById('descripcion-tarea').value;

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


<div class="max-w-md mx-auto my-10 bg-white p-6 rounded-lg shadow-inner">
    <div>
      <div class="flex items-start">
        <h1 class="text-2xl font-bold mb-6">Editar Lista de Tareas</h1>
        <button class="ml-auto" on:click={closeMenu}>
          <i class="fa-solid fa-times"></i>
        </button>
      </div>
      <div class="mb-4">
        <label for="nombre-tarea" class="block text-gray-700 font-bold mb-2">Editar el nombre  de la tarea:</label>
        <input type="text" id="nombre-tarea" placeholder={nombre} required
                class="w-full border-gray-300 rounded-md focus:outline-none focus:border-blue-500 px-4 py-2">
      </div>
  
      <div class="mb-4">
        <label for="descripcion-tarea" class="block text-gray-700 font-bold mb-2">Editar descripción:</label>
        <textarea id="descripcion-tarea"  placeholder={descripcion} 
                  class="w-full border-gray-300 rounded-md focus:outline-none focus:border-blue-500 px-4 py-2"></textarea>
      </div>
  
      <button class="bg-[#89CFF3] text-black px-4 py-2 rounded-md hover:bg-gray-300" on:click={createList}>Modificar Lista</button>
    </div>
  </div>