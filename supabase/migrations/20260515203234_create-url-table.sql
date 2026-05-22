CREATE TABLE IF NOT EXISTS urls (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    short_url VARCHAR(50) NOT NULL,
    long_url VARCHAR(100) NOT NULL,
    user_id UUID NOT NULL REFERENCES auth.users(id),
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz
);

create extension if not exists moddatetime schema extensions;

ALTER TABLE public.urls ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON TABLE public.urls TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.urls TO authenticated;
GRANT ALL ON TABLE public.urls TO service_role;

CREATE POLICY "Enable read access for all users" ON public.urls
    FOR SELECT
    USING (true);

CREATE POLICY "Enable insert access for users based on user_id" ON public.urls
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Enable update access for users based on user_id" ON public.urls
    FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Enable delete access for users based on user_id" ON public.urls
    FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

create trigger handle_updated_at
  before update on public.urls
  for each row
  execute procedure moddatetime (updated_at);