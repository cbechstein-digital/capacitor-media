import { WebPlugin } from '@capacitor/core';

import type { CapacitorMediaPlugin } from './definitions';

export class CapacitorMediaWeb extends WebPlugin implements CapacitorMediaPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
