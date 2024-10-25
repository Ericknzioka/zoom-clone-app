CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

CREATE TABLE meetings (
    id SERIAL PRIMARY KEY,
    meeting_id UUID NOT NULL,
    host_id INTEGER REFERENCES users(id),
    title VARCHAR(255),
    description TEXT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE participants (
    id SERIAL PRIMARY KEY,
    meeting_id INTEGER REFERENCES meetings(id),
    user_id INTEGER REFERENCES users(id),
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    left_at TIMESTAMP
);

CREATE TABLE meeting_history (
    id SERIAL PRIMARY KEY,
    meeting_id INTEGER REFERENCES meetings(id),
    user_id INTEGER REFERENCES users(id),
    joined_at TIMESTAMP,
    left_at TIMESTAMP,
    duration INTERVAL
);

CREATE TABLE webrtc_sessions (
    id SERIAL PRIMARY KEY,
    meeting_id INTEGER REFERENCES meetings(id),
    session_id UUID NOT NULL,
    peer_id VARCHAR(255),
    is_video BOOLEAN DEFAULT TRUE,
    is_audio BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_meeting_id ON meetings (meeting_id);
CREATE INDEX idx_user_email ON users (email);
CREATE INDEX idx_participant_meeting ON participants (meeting_id);
CREATE INDEX idx_webrtc_session ON webrtc_sessions (session_id);
