<template>
  <ProductList />
</template>

<script lang="ts">
import { defineComponent } from "vue";
import ProductList from "./components/ProductList.vue";

export default defineComponent({
  name: "App",
  components: {
    ProductList
  }
});
</script>

<style></style>
