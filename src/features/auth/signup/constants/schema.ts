import * as z from "zod";

export const SignupSchema = z
  .object({
    first_name: z
      .string({ error: "Primeiro nome é obrigatório" })
      .min(3, { error: "O primeiro nome deve conter pelo menos 3 caracteres" }),
    last_name: z
      .string({ error: "Sobrenome é obrigatório" })
      .min(3, { error: "O sobrenome deve conter pelo menos 3 caracteres" }),
    username: z.string({ error: "O nome de usuário é obrigatório" }).min(3, {
      error: "O nome de usuário deve conter pelo menos 3 caracteres",
    }),
    profile_picture_uri: z.string().optional(),
    email: z.email({ error: "Insira um e-mail válido" }),
    password1: z
      .string({ error: "Insira uma senha" })
      .min(8, { error: "A senha deve conter pelo menos 8 caracteres" }),
    password2: z.string({ error: "Insira uma confirmação de senha" }),
    gender: z
      .string({ error: "Selecione uma identidade de gênero" })
      .optional()
      .nullable(),
    sexuality: z
      .string({ error: "Selecione uma orientação sexual" })
      .optional()
      .nullable(),
    has_accepted_terms_and_conditions: z
      .boolean({ error: "Você deve aceitar os termos e condições" })
      .refine((val) => val, {
        error: "Você deve aceitar os termos e condições",
      }),
    has_accepted_privacy_policy: z
      .boolean({ error: "Você deve aceitar a política de privacidade" })
      .refine((val) => val, {
        error: "Você deve aceitar a política de privacidade",
      }),
  })
  .refine((data) => data.password1 === data.password2, {
    path: ["password2"],
    message: "As senhas não coincidem",
  });

export type SignupSchemaType = z.infer<typeof SignupSchema>;
