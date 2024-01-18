export interface CapacitorMediaPlugin {
  getLatestVideoThumbnailFromAlbum(options: GetLatestVideoThumbnailFromAlbumOptions): Promise<{ value: string }>
}

export interface GetLatestVideoThumbnailFromAlbumOptions {
  albumName: string
}
