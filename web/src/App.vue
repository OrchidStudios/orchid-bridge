<script setup lang="ts">
import UltimateList from './components/UltimateList.vue'
import { debugData } from './utils/debugData'

debugData([
  {
    action: 'openUltimateList',
    data: {
      label: 'List of placed Pots',
      items: [
        ["Knife", "Melee", "10", "0 Ammo" ],
        ["Pistol", "Ranged", "25", "12 Ammo"]
      ],
      categories: [
        { label: "Name", options: { size: 'mid' } },
        { label: "Type", options: { size: 'small', noWrap: true } },
        { label: "Damage", options: { size: 'small' } },
        { label: "Clip Size", options: { size: 'small' } }
      ],
      buttons: [
        { icon: 'fa-solid fa-edit', label: 'Rename' },
        { icon: 'fa-solid fa-trash', label: 'Delete' },
      ],
    },
  },
])
</script>

<template>
  <UltimateList />
</template>

<style scoped></style>
