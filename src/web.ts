import { WebPlugin } from '@capacitor/core';

import type {
  CapacitorMediaPlugin,
  GetLatestVideoThumbnailFromAlbumOptions,
  GetLatestVideoThumbnailFromAlbumResults
} from './definitions';

export class CapacitorMediaWeb extends WebPlugin implements CapacitorMediaPlugin {
  public getLatestVideoThumbnailFromAlbum(options: GetLatestVideoThumbnailFromAlbumOptions): Promise<GetLatestVideoThumbnailFromAlbumResults> {
    console.log(`[CapacitorMediaWeb] The method is not implemented on the web – ${options.albumName}`);
    return this.convertImageToBase64();
  }

  private async convertImageToBase64(): Promise<GetLatestVideoThumbnailFromAlbumResults> {
    try {
      const response = await fetch('assets/plugins/capacitor-media/web/placeholder.png', {
        headers: { 'Accept': 'image/png' }
      });
      const blob = await response.blob();
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onloadend = () => resolve({ value: reader.result as string });
        reader.onerror = reject;
        reader.readAsDataURL(blob);
      });
    } catch (e) {
      throw e;
    }
  }
}
