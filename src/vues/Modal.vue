<template>
  <div class="modal-vue">

    <div class="modal fade" :id="id" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ title }}</h5>
          </div>
          <div class="modal-body">{{ body }}</div>
          <div class="modal-footer">
            <button class="btn" type="button"
              v-for="option in options"
              v-on:click="selectOption(option)">
              {{ option.text }}
            </button>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script lang="coffee">

  Modal =
    props: ['id', 'title', 'body', 'options']

    methods:
      selectOption: (option) ->
        @$emit 'selectedOption', option

  export default Modal

</script>
