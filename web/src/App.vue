<script setup lang="ts">
import UltimateList from './components/UltimateList.vue'
import { debugData } from './utils/debugData'

debugData([
  {
    action: 'openUltimateList',
    data: {
      label: 'List of placed Pots',
      items: [
        [39, '1384.40, 1815.37, 98.38', 'large_pot', 'SID 2', 'weed_seed_purplehaze, weed_seed_purplehaze, weed_seed_purplehaze'],
        [60436, 'Description 1', '#19ad97', 'Description 1', '#e41bcb'],
        [64994, 'Description 1', '#ef201d', 'Description 1', '#875d74'],
        [62769, 'Description 1', '#ae5191', 'Description 1', '#b996b6'],
        [61563, 'Description 1', '#700493', 'Description 1', '#43baef'],
        [64524, 'Description 1', '#10a380', 'Description 1', '#6616ba'],
        [64967, 'Description 1', '#2934d7', 'Description 1', '#7e3801'],
        [63698, 'Description 1', '#5cb5b3', 'Description 1', '#dfae31'],
        [63450, 'Description 1', '#5d61ff', 'Description 1', '#6c3f80'],
        [63314, 'Description 1', '#3a806a', 'Description 1', '#6956e0'],
        [63108, 'Description 1', '#9fbd7a', 'Description 1', '#539635'],
        [60585, 'Description 1', '#11f8ea', 'Description 1', '#8a3cbc'],
        [61310, 'Description 1', '#689663', 'Description 1', '#2a817d'],
        [63508, 'Description 1', '#0be89c', 'Description 1', '#e9b230'],
        [60204, 'Description 1', '#fa9561', 'Description 1', '#75be3a'],
        [60753, 'Description 1', '#6ed747', 'Description 1', '#e7d9a0'],
        [61386, 'Description 1', '#fb6c7f', 'Description 1', '#d4ede2'],
        [63227, 'Description 1', '#5a09c6', 'Description 1', '#872a51'],
        [63234, 'Description 1', '#d5ce34', 'Description 1', '#96f30f'],
        [63574, 'Description 1', '#4eee62', 'Description 1', '#1453aa'],
        [60976, 'Description 1', '#d268d1', 'Description 1', '#349b16'],
        [63476, 'Description 1', '#b2e378', 'Description 1', '#77f43f'],
        [62365, 'Description 1', '#f5b5e8', 'Description 1', '#e089c7'],
        [60984, 'Description 1', '#6128ef', 'Description 1', '#6435ab'],
        [64120, 'Description 1', '#b91942', 'Description 1', '#0bbd65'],
        [60401, 'Description 1', '#08da9f', 'Description 1', '#15b5db'],
        [64234, 'Description 1', '#37360f', 'Description 1', '#0a46ca'],
        [64172, 'Description 1', '#3f3747', 'Description 1', '#e10413'],
        [61132, 'Description 1', '#85b61d', 'Description 1', '#f0bef4'],
        [61034, 'Description 1', '#2c3670', 'Description 1', '#2d711e'],
        [62178, 'Description 1', '#01ae6f', 'Description 1', '#103a23'],
        [64571, 'Description 1', '#94301b', 'Description 1', '#b2c597'],
        [63965, 'Description 1', '#da73cb', 'Description 1', '#65ed38'],
        [63655, 'Description 1', '#a75243', 'Description 1', '#eebc44'],
        [62274, 'Description 1', '#367120', 'Description 1', '#7621fa'],
        [62922, 'Description 1', '#f9da4b', 'Description 1', '#244e01'],
        [63783, 'Description 1', '#3f0a71', 'Description 1', '#e64b0a'],
        [61525, 'Description 1', '#cf5e11', 'Description 1', '#adbc8c'],
        [61500, 'Description 1', '#bf826b', 'Description 1', '#e5e0fc'],
        [63393, 'Description 1', '#e09c09', 'Description 1', '#292344'],

      ],
      categories: [
        { label: 'Net ID', options: { noWrap: false, size: 'big' }},
        { label: 'Coordinates', options: { noWrap: true }},
        { label: 'Plants in pot', options: { noWrap: false }},
        { label: 'Owner', options: { noWrap: false }},
        { label: 'Owner2', options: { noWrap: false }},
      ],
      buttons: [
        { icon: 'fas fa-edit', label: 'Edit' },
        { icon: 'fas fa-trash', label: 'Delete' },
        { icon: 'fas fa-trash', label: 'Delete' },
        { icon: 'fas fa-trash', label: 'Delete' },
        { icon: 'fas fa-trash', label: 'Delete' },
      ],
    },
  },
])
</script>

<template>
  <UltimateList />
</template>

<style scoped></style>
