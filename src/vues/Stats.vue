<template>
  <div class="stats-vue">
    {{ statstring }}
  </div>
</template>

<script lang="coffee">
  Stats =
    props: ['statstring']

  export default Stats
</script>
