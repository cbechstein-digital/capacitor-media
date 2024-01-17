import { WebPlugin } from '@capacitor/core';

import type {CapacitorMediaPlugin, GetLatestVideoThumbnailOptions} from './definitions';

export class CapacitorMediaWeb extends WebPlugin implements CapacitorMediaPlugin {
  async getLatestVideoThumbnail(options: GetLatestVideoThumbnailOptions): Promise<{ value: string }> {
    return { value: `[CapacitorMedia] ${options.albumName} – The plugin is not implemented on web` };
  }
}
