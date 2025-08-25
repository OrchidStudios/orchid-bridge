type Option = string | boolean

export type Category = {
  label: string
  options: Partial<Record<string, Option>>
}