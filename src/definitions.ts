export interface CapacitorMediaPlugin {
  getLatestVideoThumbnail(): Promise<{ value: string }>
}
