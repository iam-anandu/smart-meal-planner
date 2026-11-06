CREATE TABLE IF NOT EXISTS recommendation_generations (
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  generated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS recommendation_generations_user_time_idx
  ON recommendation_generations(user_id, generated_at DESC);
