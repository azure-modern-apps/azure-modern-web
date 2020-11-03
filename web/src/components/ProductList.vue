<template>
  <div>
    <h1>Contoso Bank - Product List</h1>
    <button v-on:click="getProducts">Refresh Products</button>
    <button v-on:click="getStatus">Refresh Status</button>
    <div><p :class="{ statusActive: statusActive }">{{ status }}</p></div>
    <div v-if="loading === true">loading...</div>
    <ul v-if="loading !== true">
      <li v-for="product of products" :key="product.productId">
        {{ product.name }}
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import axios from "axios";

export default defineComponent({
  name: "ProductList",
  props: {},
  data() {
    return {
      products: [],
      status: "",
      statusActive: false,
      loading: false
    };
  },
  async created() {
    this.getProducts();
    this.getStatus();
  },
  methods: {
    async getStatus() {
      const res = await axios.get(
        "https://api.commbank.com.au/public/cds-au/v1/discovery/status",
        {
          headers: {
            Accept: "application/json",
            "x-v": 1
          }
        }
      );
      this.status = res.data.data.status;
      this.statusActive= this.status === "OK";
    },
    async getProducts() {
      this.loading = true;
      const res = await axios.get(
        "https://api.commbank.com.au/public/cds-au/v1/banking/products",
        {
          headers: {
            Accept: "application/json",
            "x-min-v": 1,
            "x-v": 1
          }
        }
      );
      this.products = res.data.data.products;
      this.loading = false;
    }
  }
});
</script>

<style scoped>
.statusActive {
  color: greenyellow;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: block;
}
</style>
