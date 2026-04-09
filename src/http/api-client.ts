import axios, { AxiosInstance } from "axios";
import { BearerInterceptor } from "@/http/interceptors/bearer-interceptor";
import { getBaseUrl } from "@/http/get-base-url";

let axiosInstance: AxiosInstance;

function createAxiosInstance(baseURL: string) {
  return axios.create({
    baseURL,
    headers: {
      "Content-Type": "application/json",
    },
    withCredentials: false,
  });
}

export function apiClient() {
  if (axiosInstance) {
    return axiosInstance;
  }

  const baseURL = getBaseUrl();
  axiosInstance = createAxiosInstance(baseURL);

  axiosInstance.interceptors.request.use(BearerInterceptor, (error) => {
    console.error("Request interceptor error:", error);
    return Promise.reject(error);
  });

  return axiosInstance;
}

export const api = apiClient();
