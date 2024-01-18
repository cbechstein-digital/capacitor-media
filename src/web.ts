import { WebPlugin } from '@capacitor/core';

import type {CapacitorMediaPlugin, GetLatestVideoThumbnailFromAlbumOptions} from './definitions';

export class CapacitorMediaWeb extends WebPlugin implements CapacitorMediaPlugin {
  async getLatestVideoThumbnailFromAlbum(options: GetLatestVideoThumbnailFromAlbumOptions): Promise<{ value: string }> {
    return { value: `[CapacitorMedia] ${options.albumName} – The plugin is not implemented on web` };
  }
}
