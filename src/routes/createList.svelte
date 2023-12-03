<div class="max-w-md mx-auto my-10 bg-white opacity-90 p-6 rounded-lg  shadow-inner">
    <form>
      <div class="mb-4">
        <label for="nombre-tarea" class="block text-gray-700 font-bold mb-2">Nombre de la tarea:</label>
        <input type="text" id="nombre-tarea" placeholder="Ingrese el nombre de la lista de tareas" required
               class="w-full border-gray-300 rounded-md focus:outline-none focus:border-blue-500 px-4 py-2">
      </div>
  
      <div class="mb-4">
        <label for="descripcion-tarea" class="block text-gray-700 font-bold mb-2">Descripción:</label>
        <textarea id="descripcion-tarea"  placeholder="Ingrese la descripción de la lista de tareas" 
                  class="w-full border-gray-300 rounded-md focus:outline-none focus:border-blue-500 px-4 py-2"></textarea>
      </div>
  
      <button type="submit" class="bg-[#89CFF3] text-black px-4 py-2 rounded-md hover:bg-gray-300">Guardar Lista</button>
    </form>
  </div>