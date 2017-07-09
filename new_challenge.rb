require_relative 'setup'

def new_challenge(challenge_theme, challenge_start, proposer)
  @db.execute("INSERT INTO challenges (theme, start_date, maker_id)
    VALUES (?, ?, ?)", [challenge_theme, challenge_start, proposer])
  @db.execute("SELECT LAST_INSERT_ROWID();")[0][0]
end

# User interface