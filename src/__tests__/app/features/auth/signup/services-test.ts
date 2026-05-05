import { api } from "@/http/api-client";
import { signupServices } from "@/features/auth/signup/services";

jest.mock("@/http/api-client", () => ({
  api: {
    post: jest.fn(),
    patch: jest.fn(),
  },
}));

const mockPayload = {
  first_name: "João",
  last_name: "Jorge",
  username: "joaojorge",
  email: "joaojorge@gmail.com",
  password1: "joaojorge@gmail.com",
  password2: "joaojorge@gmail.com",
  has_accepted_terms_and_conditions: true,
  has_accepted_privacy_policy: false,
  profile_picture: "teste.jpg",
  gender: "OTHER",
  sexuality: "OTHER",
};

const mockResponse = {
  access:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo1MjMyNzE0NDAyLCJpYXQiOjE3NzY3MTQ0MDIsImp0aSI6IjY5NWIyZjQwMGY1YzQ2OWVhODk2N2VjNzcyOGUxMGY1IiwidXNlcl9pZCI6ImYzZjdmZDJhLTI2YmEtNDFlOC1iZDM5LWIxZWU0M2MxOWVhYiJ9.SA305jk-ZOMxo6x_AveXx34S9GbGp_1UCd9_4fuAkDE",
  refresh:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3ODAxMDQwMiwiaWF0IjoxNzc2NzE0NDAyLCJqdGkiOiJmNTM3ZGI1YjZmMDQ0N2UyYTg0MjdlMGYyNjNjNjYyMSIsInVzZXJfaWQiOiJmM2Y3ZmQyYS0yNmJhLTQxZTgtYmQzOS1iMWVlNDNjMTllYWIifQ.LV8XfH04UC-ccO4EAuZLEx--qHmb50JlagAL8ohepYU",
  user: {
    id: "f3f7fd2a-26ba-41e8-bd39-b1ee43c19eab",
    relationship: null,
    last_login: "2026-04-20T16:46:42.100914-03:00",
    is_superuser: false,
    username: "joaojorge",
    first_name: "João",
    last_name: "Jorge",
    is_staff: false,
    is_active: true,
    date_joined: "2026-04-20T16:46:41.950795-03:00",
    email: "joaojorge@gmail.com",
    gender: "OTHER",
    sexuality: "OTHER",
    profile_picture: "teste.jpg",
    connection_code: "97BKSD",
    has_accepted_terms_and_conditions: true,
    has_accepted_privacy_policy: false,
    groups: [],
    user_permissions: [],
  },
};

describe("signup services", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe("user signup", () => {
    it("should successfully create new user", async () => {
      (api.post as jest.Mock).mockResolvedValue({ data: mockResponse });
      const result = await signupServices.signup(mockPayload);

      expect(api.post).toHaveBeenCalledWith(
        "/api/auth/registration/",
        mockPayload,
      );
      expect(result).toEqual(mockResponse);
    });

    it("should propagate an error if user signup fails", async () => {
      const mockError = new Error("Um erro ocorreu.");
      (api.post as jest.Mock).mockRejectedValue(mockError);

      await expect(signupServices.signup(mockPayload)).rejects.toThrow(
        mockError,
      );
    });
  });

  describe("profile pic presign", () => {
    const mockPresignResponse = {
      folder: "teste",
      public_id: "teste.jpg",
      signature: "48fcffc1b95f03395d917e2a2ce7e922d26f2158",
      timestamp: 1776714942,
    };
    it("should successfully presign profile pic", async () => {
      (api.post as jest.Mock).mockResolvedValue({ data: mockPresignResponse });
      const result = await signupServices.presignProfilePictureUpload(
        "teste.jpg",
        "teste",
      );

      expect(api.post).toHaveBeenCalledWith("/api/global/image/presign/", {
        file_name: "teste.jpg",
        folder_name: "teste",
      });
      expect(result).toEqual(mockPresignResponse);
    });
  });
  describe("update user profile image", () => {
    const mockUpdateProfilePicture = {
      message: "Usuário atualizado com sucesso",
    };
    it("should successfully presign profile pic", async () => {
      (api.patch as jest.Mock).mockResolvedValue({
        data: mockUpdateProfilePicture,
      });
      const result =
        await signupServices.updateUserWithProfilePicture("https://teste.jpg");

      expect(api.patch).toHaveBeenCalledWith("/api/user/", {
        profile_picture: "https://teste.jpg",
      });
      expect(result).toEqual(mockUpdateProfilePicture);
    });
  });
});
