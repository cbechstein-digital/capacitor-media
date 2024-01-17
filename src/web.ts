import { WebPlugin } from '@capacitor/core';

import type { CapacitorMediaPlugin } from './definitions';

export class CapacitorMediaWeb extends WebPlugin implements CapacitorMediaPlugin {
  async getLatestVideoThumbnail(): Promise<{ value: string }> {
    return { value: 'Not implemented' };
  }
}
