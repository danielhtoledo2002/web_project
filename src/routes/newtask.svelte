<script>
    let task = {
      name: "",
      description: "",
      dueDate: "",
      priority: "",
      assignedList: "",
    };
  
    const priorityOptions = ["Low", "Medium", "High", "Critical"];
    const listOptions = ["List 1", "List 2", "List 3"]; // Agrega tus propias opciones de lista
  
    const handleSubmit = () => {
      // Aquí puedes realizar la lógica para manejar el envío del formulario con el objeto task
      console.log(task);
    };
  </script>
  
  <style>
    /* Agrega tus estilos aquí */
  </style>
  <main class="bg-[#89CFF3] max-w-lg mx-auto p-8 md:p-12 my-10 rounded-lg shadow-2xl">
  <div>
    <label for="name">Nombre</label>
    <input type="text" id="name" bind:value={task.name} />
  
    <label for="description">Descripción</label>
    <textarea id="description" bind:value={task.description}></textarea>
  
    <label for="dueDate">Fecha de Entrega</label>
    <input type="date" id="dueDate" bind:value={task.dueDate} />
  
    <label for="priority">Prioridad</label>
    <select id="priority" bind:value={task.priority}>
      {#each priorityOptions as option (option)}
        <option value={option}>{option}</option>
      {/each}
    </select>
  
    <label for="assignedList">Lista Asignada</label>
    <select id="assignedList" bind:value={task.assignedList}>
      {#each listOptions as option (option)}
        <option value={option}>{option}</option>
      {/each}
    </select>
  
    <button on:click={handleSubmit}>Crear Tarea</button>

  </div>
  </main>