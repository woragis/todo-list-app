import { useAboutModel } from "./model";

export const AboutView = ({
  aboutMainTitle,
  aboutMainText,
}: ReturnType<typeof useAboutModel>) => {
  return (
    <main>
      <h1>{aboutMainTitle}</h1>
      <p>{aboutMainText}</p>
    </main>
  );
};
