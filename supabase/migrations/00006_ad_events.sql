create table public.ad_events (
  id bigserial primary key,
  slot text not null,
  event text not null,
  placement_id text,
  revenue numeric(10,4) default 0,
  device_id text,
  extra jsonb,
  created_at timestamptz not null default now()
);

create index ad_events_created_idx on public.ad_events (created_at desc);
create index ad_events_slot_idx on public.ad_events (slot, event, created_at desc);

alter table public.ad_events enable row level security;

create policy ad_events_deny_anon on public.ad_events
  for all to anon using (false) with check (false);
create policy ad_events_deny_authenticated on public.ad_events
  for all to authenticated using (false) with check (false);