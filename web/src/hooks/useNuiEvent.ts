import { onMounted, onUnmounted, ref } from 'vue'

interface NuiMessageData<T = unknown> {
  action: string
  data: T
}

type NuiHandlerSignature<T> = (data: T) => void

/**
 * A composable function for Vue 3 that listens for specific messages posted to the window
 * and handles them using a provided function. This mimics the behavior of a custom React hook
 * but utilizes Vue's reactivity and lifecycle hooks.
 *
 * @param action The specific `action` type to listen for in the messages.
 * @param handler A function to handle the data when a message with the correct action is received.
 *
 * @example
 * useNuiEvent<{right?: any, left?: any}>('setupInventory', (data) => {
 *   console.log(data);
 * });
 *
 * Code by Overextened https://github.com/overextended/ox_inventory
 */

const useNuiEvent = <T = any>(action: string, handler: NuiHandlerSignature<T>): void => {
  const savedHandler = ref<NuiHandlerSignature<T>>(handler)

  onMounted(() => {
    const eventListener = (event: MessageEvent<NuiMessageData<T>>) => {
      const { action: eventAction, data } = event.data
      if (savedHandler.value) {
        if (eventAction === action) {
          savedHandler.value(data)
        }
      }
    }

    window.addEventListener('message', eventListener)

    onUnmounted(() => {
      window.removeEventListener('message', eventListener)
    })
  })
}

export default useNuiEvent
