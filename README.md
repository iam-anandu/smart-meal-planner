# Smart Meal Planner

Personalized recipe recommendations with a React/TypeScript client and Node/TypeScript API. The API uses PostgreSQL for accounts, preference profiles, pantry, the seeded recipe library, AI generations and saved recipes. GLM 4.5 prompts/configuration and the API key are server-only; model output is strictly validated and filtered before it is returned. Nutrition is always an estimate, not medical advice.

## Requirements

Node.js 20+ and PostgreSQL 14+. Set `DATABASE_URL` in the server process environment. For AI generation, provide `GLM_API_KEY` only to the server; optional server settings are `GLM_MODEL` (default `glm-4.5`), `GLM_BASE_URL`, `PORT` (default `3000`) and `PGSSL=true`. Do not put credentials in the client or commit a local environment file.

## Run locally

1. `npm install`
2. Create a PostgreSQL database and set `DATABASE_URL` in the environment.
3. `npm run migrate` then `npm run seed`.
4. In one terminal run `npm run dev:server`; in another run `npm run dev:web`.
5. Open the Vite URL. Register with an email and a password of at least 10 characters. Vite proxies `/api` to the backend.

`npm test` runs the server and web unit tests once. `npm run build` builds both packages. `npm start -w server` starts the compiled API. The health endpoint is `/api/health`.

## Recommendation behavior

The API ranks recipes from its seeded library using pantry overlap, then asks GLM 4.5 to fill available slots when needed. Output is schema-validated, retried once on invalid/provider failure, and hard-filtered against saved allergies and diet before persistence or display. Unavailable AI degrades to safe library matches with a notice; generation is rate-limited per user. Allergy filtering also checks ingredient names conservatively in addition to declared tags. Saved AI recipes remain attached to their owning account. AI nutrition values are estimates and not medically verified.
