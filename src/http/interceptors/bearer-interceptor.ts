import { InternalAxiosRequestConfig } from "axios";
import { getData } from "@/lib/storage";
import { router } from "expo-router";

export const BearerInterceptor = async (
  config: InternalAxiosRequestConfig,
): Promise<InternalAxiosRequestConfig> => {
  const token = await getData("access_token");

  if (!token) {
    router.navigate("/welcome");
    return config;
  }

  config.headers.set("Authorization", `Bearer ${token}`);

  return config;
};
