export interface CapacitorMediaPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
