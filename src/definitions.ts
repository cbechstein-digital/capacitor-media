export interface CapacitorMediaPlugin {
  getLatestVideoThumbnail(options: GetLatestVideoThumbnailOptions): Promise<{ value: string }>
}

export interface GetLatestVideoThumbnailOptions {
  albumName: string
}
