import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.bechstein.CapacitorMediaExample',
  appName: 'capacitor-media-example',
  webDir: 'dist/example/browser',
  server: {
    androidScheme: 'https'
  }
};

export default config;
