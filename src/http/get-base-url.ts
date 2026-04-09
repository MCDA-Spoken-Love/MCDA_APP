import Constants from "expo-constants";

export function getBaseUrl(): string {
  // 1) build-time env (EAS or bundling tools)
  if (process.env.EXPO_PUBLIC_BASE_URL) {
    return process.env.EXPO_PUBLIC_BASE_URL;
  }

  // 2) expo extras (app.json -> expo.extra.apiUrl). Good for dev and EAS.
  const extras = (Constants.expoConfig?.extra ??
    (Constants.manifest as any)?.extra) as any | undefined;
  if (extras?.apiUrl) {
    return extras.apiUrl;
  }

  // 3) derive from the packager hostUri if available (dev)
  const hostUri =
    Constants.expoConfig?.hostUri ??
    (Constants.manifest as any)?.packagerOpts?.host;
  if (hostUri) {
    const ip = String(hostUri).split(":").shift();
    if (ip) {
      // adjust port to your backend port (here 8000)
      return `http://${ip}:8000`;
    }
  }

  // 4) emulator defaults (Android emulator)
  return "http://10.0.2.2:8000";
}
