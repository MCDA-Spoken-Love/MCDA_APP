import {
  SignupSchema,
  SignupSchemaType,
} from "@/features/auth/signup/constants/schema";

const mockSchemaData: SignupSchemaType = {
  username: "joao",
  password1: "12345678",
  email: "joao@email.com",
  first_name: "joão",
  last_name: "bosco",
  password2: "12345678",
  profile_picture: "mock-uri://photo.jpg",
  gender: "OTHER",
  sexuality: "OTHER",
  has_accepted_terms_and_conditions: true,
  has_accepted_privacy_policy: true,
};

const mockPartialSchemaData: SignupSchemaType = {
  username: "joao",
  password1: "12345678",
  email: "joao@email.com",
  first_name: "joão",
  last_name: "bosco",
  password2: "12345678",
  has_accepted_terms_and_conditions: true,
  has_accepted_privacy_policy: true,
};

describe("SignupSchema validation", () => {
  it("should pass with all complete data", () => {
    const validData: SignupSchemaType = mockSchemaData;
    const result = SignupSchema.safeParse(validData);
    expect(result.success).toBe(true);
  });

  it("should pass with partial valid data", () => {
    const validData: SignupSchemaType = mockPartialSchemaData;
    const result = SignupSchema.safeParse(validData);
    expect(result.success).toBe(true);
  });

  it("should fail on short username", () => {
    const invalidData = { ...mockSchemaData, username: "jo" };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain("username");
    }
  });

  it("should fail on short first_name", () => {
    const invalidData = { ...mockSchemaData, first_name: "jo" };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain("first_name");
    }
  });

  it("should fail on short last_name", () => {
    const invalidData = { ...mockSchemaData, last_name: "jo" };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain("last_name");
    }
  });

  it("should fail on invalid email address", () => {
    const invalidData = { ...mockSchemaData, email: "jo" };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain("email");
    }
  });

  it("should fail on short password1", () => {
    const invalidData = { ...mockSchemaData, password1: "jo" };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain("password1");
    }
  });

  it("should fail on password2 not matching password2", () => {
    const invalidData = { ...mockSchemaData, password2: "123456789" };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain("password2");
    }
  });

  it("should fail on false has_accepted_terms_and_conditions", () => {
    const invalidData = {
      ...mockSchemaData,
      has_accepted_terms_and_conditions: false,
    };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain(
        "has_accepted_terms_and_conditions",
      );
    }
  });

  it("should fail on false has_accepted_privacy_policy", () => {
    const invalidData = {
      ...mockSchemaData,
      has_accepted_privacy_policy: false,
    };
    const result = SignupSchema.safeParse(invalidData);
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.issues[0].path).toContain(
        "has_accepted_privacy_policy",
      );
    }
  });
});
