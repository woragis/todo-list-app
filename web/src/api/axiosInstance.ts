import axios from "axios";

const axiosInstance = axios.create({
  baseURL: "http://127.0.0.1:8080/",
  timeout: 10000,
});

axiosInstance.interceptors.request.use(
  (config: any) => {
    const token = localStorage.getItem("authToken");
    if (token) {
      config.headers.Authorization = {
        ...config.headers,
        Authorization: `Bearer ${token}`,
      };
    }

    return config;
  },

  (error) => {
    return Promise.reject(error);
  }
);

export default axiosInstance;
