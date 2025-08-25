export class Queue {
  private items: any[] = []

  // Add an element to the end of the queue
  push(element: any): void {
    this.items.push(element)
  }

  // Remove an element from the front of the queue
  pop(): any | undefined {
    return this.items.shift()
  }

  // Get the element at the front of the queue without removing it
  front(): any | undefined {
    return this.items[0]
  }

  // Get the element at the back of the queue without removing it
  back(): any | undefined {
    return this.items[this.items.length - 1]
  }

  // Check if the queue is empty
  empty(): boolean {
    return this.items.length === 0
  }

  // Get the size of the queue
  size(): number {
    return this.items.length
  }

  // Clear the queue
  clear(): void {
    this.items = []
  }

  // Convert the queue to a string
  toString(): string {
    return this.items.toString()
  }
}
