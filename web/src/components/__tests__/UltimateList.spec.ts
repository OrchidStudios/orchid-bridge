import { describe, it, expect, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import UltimateList from '../UltimateList.vue'

vi.mock('@/utils/fetchNui', () => ({
  fetchNui: vi.fn(),
}))

describe('UltimateList.vue', () => {
  const mockData =   {
      label: 'List of placed Pots',
      items: [
        ['Item 1', 'Description 1', 'Value 1', 'Description 1', 'Value 1'],
        ['Item 2', 'Description 1', 'Value 1', 'Description 1', 'Value 1'],
        ['Item 3', 'Description 1', 'Value 1', 'Description 1', 'Value 1'],
        ['Item 4', 'Description 1', 'Value 1', 'Description 1', 'Value 1'],
        ['Item 5', 'Description 1', 'Value 1', 'Description 1', 'Value 1'],
      ],
      columns: ['Net ID', 'Coordinates', 'Plants in pot', 'Owner', 'Placement Time'],
      buttons: [
        { icon: 'fas fa-edit', label: 'Edit' },
        { icon: 'fas fa-trash', label: 'Delete' },
      ],
    }

  const mountWithAttach = () =>
    mount(UltimateList, {
      attachTo: document.body
    })

  it('does not render before openUltimateList event', () => {
    const wrapper = mountWithAttach()
    expect(wrapper.find('.window').exists()).toBe(false)
  })

  it('renders list when receiving openUltimateList message', async () => {
    const wrapper = mountWithAttach()

    window.dispatchEvent(
      new MessageEvent('message', {
        data: { action: 'openUltimateList', data: mockData },
      })
    )

    await wrapper.vm.$nextTick()

    expect(wrapper.find('.window').exists()).toBe(true)
    expect(wrapper.text()).toContain('placed Pots')
    expect(wrapper.text()).toContain('Item 1')
    expect(wrapper.text()).toContain('Item 2')
    expect(wrapper.text()).toContain('Item 3')
  })

  it('closes when receiving closeUltimateList message', async () => {
    const wrapper = mountWithAttach()

    window.dispatchEvent(
      new MessageEvent('message', {
        data: { action: 'openUltimateList', data: mockData },
      })
    )
    await wrapper.vm.$nextTick()

    window.dispatchEvent(
      new MessageEvent('message', { data: { action: 'closeUltimateList' } })
    )
    await wrapper.vm.$nextTick()

    expect(wrapper.find('.window').exists()).toBe(false)
  })

  it('filters items based on searchQuery', async () => {
    const wrapper = mountWithAttach()

    window.dispatchEvent(
      new MessageEvent('message', {
        data: { action: 'openUltimateList', data: mockData },
      })
    )
    await wrapper.vm.$nextTick()

    const input = wrapper.find('input')
    await input.setValue('Item 2')

    expect(wrapper.text()).toContain('Item 2')
    expect(wrapper.text()).not.toContain('Item 1')
  })

  it('calls fetchNui when button is clicked', async () => {
    const { fetchNui } = await import('@/utils/fetchNui')
    const wrapper = mountWithAttach()

    window.dispatchEvent(
      new MessageEvent('message', {
        data: { action: 'openUltimateList', data: mockData },
      })
    )
    await wrapper.vm.$nextTick()

    const button = wrapper.find('.buttons button')
    await button.trigger('click')

    expect(fetchNui).toHaveBeenCalledWith('listButtonClicked', {
      itemIndex: 1,
      buttonIndex: 1,
    })
  })

  it('closes when ESC button is pressed', async () => {
    const wrapper = mountWithAttach()

    window.dispatchEvent(
      new MessageEvent('message', {
        data: { action: 'openUltimateList', data: mockData },
      })
    )
    await wrapper.vm.$nextTick()

    await wrapper.find('header button').trigger('click')
    expect(wrapper.find('.window').exists()).toBe(false)
  })
})
