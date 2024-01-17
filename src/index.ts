import { registerPlugin } from '@capacitor/core';

import type { CapacitorMediaPlugin } from './definitions';

const CapacitorMedia = registerPlugin<CapacitorMediaPlugin>('CapacitorMedia', {
  web: () => import('./web').then(m => new m.CapacitorMediaWeb()),
});

export * from './definitions';
export { CapacitorMedia };
