-- Users
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() primary key,
    flake_id bigint not null unique,
    username text NOT NULL,
    name text NOT NULL,
    avatar text default null,
    oauth_type text not null,
    oauth_id text not null,
    language text default null,
    timezone integer default null,
    status text DEFAULT null,
    no_invite boolean DEFAULT false,
    block boolean DEFAULT false,
    channels uuid[] default null,
    contacts uuid[] default null,
    created_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone NOT NULL);

  ALTER TABLE users ADD CONSTRAINT users_oauth_id_key UNIQUE (oauth_id);
  ALTER TABLE users ADD CONSTRAINT users_username_key UNIQUE (username);
  ALTER TABLE users ADD CONSTRAINT created_at_chk CHECK (EXTRACT(TIMEZONE from created_at) = '0');
  ALTER TABLE users ADD CONSTRAINT last_seen_at_chk CHECK (EXTRACT(TIMEZONE from last_seen_at) = '0');
CREATE INDEX users_last_seen_at_index ON users(last_seen_at DESC);
CREATE INDEX users_created_at_index ON users(created_at DESC);

-- Invites
CREATE TABLE invites (
    user_id UUID NOT NULL,
    invite_id UUID NOT NULL,
    state text NOT NULL default 'pending',
    created_at timestamp with time zone NOT NULL
    );
  ALTER TABLE invites ADD CONSTRAINT invites_user_id_invite_id_key UNIQUE (user_id, invite_id);
  ALTER TABLE invites ADD CONSTRAINT created_at_chk CHECK (EXTRACT(TIMEZONE from created_at) = '0');

-- stats
CREATE TABLE stats (
    type text not null,
    day date not null,
    value bigint not null default 0);
  ALTER TABLE stats ADD CONSTRAINT stats_type_day UNIQUE (type,day);

-- reports
CREATE TABLE reports (
    id UUID DEFAULT uuid_generate_v4() primary key,
    user_id UUID NOT NULL,
    type text not null,
    type_id UUID not null,
    title text not null,
    picture text default null,
    description text default null,
    block boolean default false,
    data json default null,
    created_at timestamp with time zone NOT NULL);
  ALTER TABLE reports ADD CONSTRAINT created_at_chk CHECK (EXTRACT(TIMEZONE from created_at) = '0');

-- channels
CREATE TABLE channels (
    id UUID DEFAULT uuid_generate_v4() primary key,
    name text unique not null,
    user_id UUID NOT NULL,
    is_private boolean default false,
    need_invite boolean default false,
    purpose text default null,
    members_count integer not null default 0,
    type text default null,
    picture text default null,
    block boolean default false,
    locale text default 'english',
    created_at timestamp with time zone NOT NULL);
  ALTER TABLE channels ADD CONSTRAINT created_at_chk CHECK (EXTRACT(TIMEZONE from created_at) = '0');

CREATE TABLE channels_members (
    channel_id UUID not null,
    user_id UUID not null,
    created_at timestamp with time zone NOT NULL);
  ALTER TABLE channels_members ADD CONSTRAINT created_at_chk CHECK (EXTRACT(TIMEZONE from created_at) = '0');
  ALTER TABLE channels_members ADD CONSTRAINT channel_id_user_id UNIQUE (channel_id,user_id);
