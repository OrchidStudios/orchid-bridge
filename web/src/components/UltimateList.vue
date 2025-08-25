<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import useNuiEvent from '@/hooks/useNuiEvent'
import { fetchNui } from '@/utils/fetchNui'
import { useVirtualList } from '@vueuse/core'
import 'floating-vue/dist/style.css'
import Divider from './Divider.vue'
import type { Category } from '@/typings/Category'



const showList = ref(false)
const searchQuery = ref('')
const currentlyOpened = ref<number | null>(null)
const gridRef = ref<HTMLDivElement>()
const listData = ref<{
  label: string
  items: Array<{ text: Array<string>; index: number }>
  buttons: Array<{ icon: string; label: string }>
  categories: Array<Category>
} | null>(null)
const categoriesSize = computed(() => {
  return (listData.value?.categories.length || 1)
})

useNuiEvent<{
  label: string
  items: Array<Array<string>>
  categories: Array<Category>
  buttons: Array<{ icon: string; label: string }>
}>('openUltimateList', (data) => {
  showList.value = true
  listData.value = {
    label: data.label,
    items: data.items.map((item, index) => {
      return { text: item, index: index }
    }),
    buttons: data.buttons,
    categories: data.categories
  }
})

useNuiEvent<{}>('closeUltimateList', () => {
  close(true)
})

const buttonClicked = (itemIndex: number, btnIndex: number) => {
  fetchNui('listButtonClicked', {
    itemIndex: itemIndex + 1,
    buttonIndex: btnIndex + 1,
  })
}

const filteredItems = computed(() => {
  return (
    listData.value?.items.filter((item) => {
      return item.text.some((value) => value.toString().toLowerCase().includes(searchQuery.value.toLowerCase()))
    }) || []
  )
})

const rowHeight = 50

const { list, containerProps, wrapperProps } = useVirtualList(filteredItems, {
  itemHeight: rowHeight,
  overscan: 2,
})

const close = (dontFetch?: boolean) => {
  showList.value = false
  listData.value = null
  currentlyOpened.value = null
  if (!dontFetch) {
    fetchNui('closeList')
  }
}

const escListener = (event: KeyboardEvent) => {
  if (event.key === 'Escape') {
    close()
  }
}

function sizeToFr(size: string | boolean | undefined) {
  switch (size) {
    case 'small': return '0.4fr';
    case 'mid': return '0.7fr';
    case 'big': return '1.2fr';
    default: return '1fr';
  }
}

const templateColumns = computed(() => {
  return (listData.value?.categories.map(category => sizeToFr(category.options?.size)).join(' ') || '')
})

onMounted(() => {
  addEventListener('keydown', escListener)
})

onUnmounted(() => {
  removeEventListener('keydown', escListener)
})

</script>

<template>
  <div v-if="showList" class="window">
    <header>
      <h4>{{ listData?.label }}</h4>
      <div>
        <input type="text" v-model="searchQuery" placeholder="Поиск" />
        <button @click="close()">ESC</button>
      </div>
    </header>
    <div class="list-container">
      <li>
        <div>
          <div class="info" ref="gridRef">
            <p v-for="(column, colIndex) in listData?.categories" :key="colIndex">{{ column.label }}</p>
          </div>
          <div class="buttons">
            <div v-for="(b, bi) in listData?.buttons" :key="bi" style="width: 16px;">
            </div>
          </div>
        </div>
      </li>
      <Divider />
      <div class="scroll-container" v-bind="containerProps" style="max-height: 80vh;">
        <ul v-bind="wrapperProps" style="height: min-content;">
          <template v-for="(item, index) in list" :key="index" v-if="list.length > 0">
            <li>
              <div>
                <div class="info" ref="gridRef">
                  <p v-for="(text, i) in item.data.text" :key="i" :style="{
                    textWrap: listData?.categories[i]?.options?.noWrap ? 'nowrap' : 'wrap',
                  }">{{ text }}</p>
                </div>
                <div class="buttons">
                  <button v-for="(button, btnIndex) in listData?.buttons" :key="btnIndex"
                    @click.stop="buttonClicked(item.data.index, btnIndex)" v-tooltip="button.label">
                    <fas :icon="button.icon" style="width:16px; height:16px" color="var(--vt-c-text-light-1)" />
                  </button>
                </div>
              </div>
            </li>
            <Divider v-if="index !== list.length - 1" />
          </template>
          <h4 v-else>
            No Items Found
          </h4>
        </ul>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
@use 'sass:color';
@import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap');


$gap: 1rem;
$sidePadding: 1.9rem;

* {
  font-weight: 500;
}

.window {
  background-color: rgba(16, 23, 37, 0.897);
  border-radius: 14px;
  padding: 25px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  width: 60vw;
  position: absolute;
  right: 2vh;
  top: 2vh;

  header {
    display: flex;
    justify-content: space-between;
    align-items: center;

    h4 {
      font-weight: 600;
      font-size: 1.1rem;
    }

    >div {
      display: flex;
      align-items: center;

      >input {
        display: flex;
        padding: 0 0.625rem;
        height: 1.6rem;
        justify-content: space-between;
        align-items: center;
        margin-right: 0.8rem;
        border-radius: 0.375rem;
        border: none;
        color: var(--vt-c-text-light-1);
        background: rgba(184, 184, 184, 0.6);
        outline: none;

        &::placeholder {
          color: #f6f6f677;
        }
      }

      button {
        cursor: pointer;
        display: flex;
        height: 1.6rem;
        padding: 0 0.625rem;
        justify-content: space-between;
        align-items: center;
        flex-shrink: 0;
        border-radius: 0.375rem;
        color: var(--vt-c-text-light-1);
        background: #24b9d4;
        border: none;
        font-weight: 600;

        font-family: 'Open Sans', sans-serif;
      }
    }
  }

  .list-container {
    margin-top: 1.5vh;
    border-radius: 0.625rem;
    border: 1px solid #444F65;

    >li {
      padding: $gap 0;
    }
  }

  .scroll-container {
    padding: $gap 0;

    ul {
      align-self: stretch;
      display: flex;
      flex-direction: column;
      gap: $gap;

      position: relative;

      >h4 {
        padding: 0 $sidePadding;
      }


    }
  }

  li {
    list-style-type: none;

    >div {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 $sidePadding;

      .buttons {
        display: flex;
        width: min-content;
        gap: 0.5rem;

        button {
          border: none;
          background-color: transparent;
          display: flex;
          cursor: pointer;
        }
      }


      .info {
        flex: 0.98;
        display: grid;
        grid-template-columns: v-bind(templateColumns);
        gap: 0.5rem;
      }
    }
  }

  ::-webkit-scrollbar {
    width: 4px;
  }

  ::-webkit-scrollbar-thumb {
    background-color: #24b9d4;
    border-radius: 4px;
    transition: 0.2s;
  }

  ::-webkit-scrollbar-thumb:hover {
    background-color: color.adjust(#24b9d4, $lightness: 10%);
  }
}
</style>
