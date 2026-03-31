import axios, { AxiosInstance } from "axios";

export const api: AxiosInstance = axios.create({
  baseURL: process.env.EXPO_PUBLIC_BASE_URL,
  withCredentials: true,
  withXSRFToken: true,
});
