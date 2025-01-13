import axiosInstance from "../../api/axiosInstance";
import { API_ENDPOINTS } from "../../api/endpoints";
import {
  CreatePostRequest,
  PostResponse,
  PostsResponse,
} from "../../types/posts.types";

export const getPostsService = async (token: string) => {
  console.log("API: starting posts 'get (many)' request");
  const response = await axiosInstance.get(API_ENDPOINTS.POSTS, {
    headers: { authorization: `Bearer ${token}` },
  });
  console.log("API: finished posts 'get (many)' request");
  return response.data as PostsResponse;
};

export const createPostService = async (
  token: string,
  post: CreatePostRequest
) => {
  console.log("API: starting posts 'post' request");
  const response = await axiosInstance.post(API_ENDPOINTS.POSTS, post, {
    headers: { authorization: `Bearer ${token}` },
  });
  console.log("API: finished posts 'post' request");
  return response.data as PostResponse;
};

export const getPostService = async (token: string, post_id: number) => {
  console.log("API: starting posts 'get' request");
  const response = await axiosInstance.get(
    API_ENDPOINTS.POSTS + `/${post_id}`,
    {
      headers: { authorization: `Bearer ${token}` },
    }
  );
  console.log("API: finished posts 'get' request");
  return response.data as PostResponse;
};

export const updatePostService = async (
  token: string,
  post_id: number,
  post: CreatePostRequest
) => {
  console.log("API: starting posts 'put' request");
  const response = await axiosInstance.post(
    API_ENDPOINTS.POSTS + `/${post_id}`,
    post,
    {
      headers: { authorization: `Bearer ${token}` },
    }
  );
  console.log("API: finished posts 'put' request");
  return response.data as PostResponse;
};

export const deletePostService = async (token: string, post_id: number) => {
  console.log("API: starting posts 'delete' request");
  const response = await axiosInstance.delete(
    API_ENDPOINTS.POSTS + `/${post_id}`,
    {
      headers: { authorization: `Bearer ${token}` },
    }
  );
  console.log("API: finished posts 'delete' request");
  return response.data as boolean;
};
