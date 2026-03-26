export enum GenderEnum {
  CISMALE = "CISMALE",
  CISFEMALE = "CISFEMALE",
  TRANSMALE = "TRANSMALE",
  TRANSFEMALE = "TRANSFEMALE",
  NONBINARY = "NONBINARY",
  INTERSEX = "INTERSEX",
  AGENDER = "AGENDER",
  OTHER = "OTHER",
  PREFERNOTTOSAY = "PREFERNOTTOSAY",
}

export enum SexualityEnum {
  HETEROSEXUAL = "HETEROSEXUAL",
  HOMOSEXUAL = "HOMOSEXUAL",
  BISEXUAL = "BISEXUAL",
  ASEXUAL = "ASEXUAL",
  PANSEXUAL = "PANSEXUAL",
  DEMISEXUAL = "DEMISEXUAL",
  POLYSEXUAL = "POLYSEXUAL",
  OTHER = "OTHER",
  PREFERNOTTOSAY = "PREFERNOTTOSAY",
}

export const genderList = [
  { label: "Homem Cis", value: GenderEnum.CISMALE },
  { label: "Mulher Cis", value: GenderEnum.CISFEMALE },
  { label: "Homem Trans", value: GenderEnum.TRANSMALE },
  { label: "Mulher Trans", value: GenderEnum.TRANSFEMALE },
  { label: "Não Binário", value: GenderEnum.NONBINARY },
  { label: "Intersexo", value: GenderEnum.INTERSEX },
  { label: "Agênero", value: GenderEnum.AGENDER },
  { label: "Outro", value: GenderEnum.OTHER },
  { label: "Prefiro não informar", value: GenderEnum.PREFERNOTTOSAY },
];

export const sexualityList = [
  { label: "Heterossexual", value: SexualityEnum.HETEROSEXUAL },
  { label: "Homossexual", value: SexualityEnum.HOMOSEXUAL },
  { label: "Bissexual", value: SexualityEnum.BISEXUAL },
  { label: "Assexual", value: SexualityEnum.ASEXUAL },
  { label: "Pansexual", value: SexualityEnum.PANSEXUAL },
  { label: "Demissexual", value: SexualityEnum.DEMISEXUAL },
  { label: "Polissexual", value: SexualityEnum.POLYSEXUAL },
  { label: "Outro", value: SexualityEnum.OTHER },
  { label: "Prefiro não informar", value: SexualityEnum.PREFERNOTTOSAY },
];
