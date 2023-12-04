<script>
  import { goto } from '$app/navigation'

  export let nombre = "";
  export let apellido = "";

  function gotoListas() {
    goto("/listas");
  }

  function gotoUser() {
    goto("/user");
  }
</script>

<main class="bg-[#A0E9FF] flex flex-col justify-center items-center flex-grow flex-wrap">
    <nav class="flex items-center justify-between w-full p-4 flex-wrap">
      <div class="flex items-center text-black flex-wrap">
        <button class="flex" on:click={gotoListas}>
          <h1 class="font-bold text-[#FFF]">
            <i class="fa-solid fa-cloud"></i>
          </h1>
          <span class="font-semibold tracking-tight ml-2">ListaKLista</span>
        </button>
        
      </div>
      <div class="flex flex-wrap" >
        <button class="flex" on:click={gotoUser}>
            <p class="font-bold text-black pr-3">{nombre} {apellido}</p>
            <h1 class="font-bold text-black"><i class="fa-solid fa-user"></i></h1>
        </button>
      </div>
    </nav>
  </main>
  