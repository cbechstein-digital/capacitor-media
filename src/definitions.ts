export interface CapacitorMediaPlugin {
  /**
   * Returns a thumbnail from the newest video in a specific album
   *
   * @method
   * @param {GetLatestVideoThumbnailFromAlbumOptions} options – The album name and the size of the resulting thumbnail. The album name is not supported and will be ignored on Android.
   * @returns {GetLatestVideoThumbnailFromAlbumResults} – The resulting video thumbnail with the specified dimensions.
   *
   * @example
   * CapacitorMedia.getLatestVideoThumbnailFromAlbum({
   *     albumName: 'CB Creator',
   *     size: {
   *         width: 200,
   *         height: 200
   *     }
   * })
   */
  getLatestVideoThumbnailFromAlbum(options: GetLatestVideoThumbnailFromAlbumOptions): Promise<GetLatestVideoThumbnailFromAlbumResults>
}


/**
 * @interface
 * @property {string} albumName – The name of the album to look for the latest video.
 * @property {ThumbnailSize} size – The size of the resulting thumbnail.
 */
export interface GetLatestVideoThumbnailFromAlbumOptions {
  albumName: string;
  size: ThumbnailSize;
}


/**
 * @interface
 * @property {string} value – The based 64 encoded representation of the thumbnail.
 */
export interface GetLatestVideoThumbnailFromAlbumResults {
  value: string;
}


/**
 * @interface
 * @property {number} width – Width of the thumbnail. Suggested value is 200.
 * @property {number} height – Height of the thumbnail. Suggested value is 200.
 *
 * @example
 * // Implementing the ThumbnailSize interface with default values
 * const size = {
 *     width: 200,
 *     height: 200
 * }
 */
export interface ThumbnailSize {
  width: number;
  height: number;
}