require 'csv'
require_relative 'registration'
require_relative 'new_challenge'

THEME = "Super Heroes"

RATINGS_CSV_FILE = "super_heroi.csv"

CIDs = [
  'A808-0000-033C-C953',
  'EA2F-0000-033D-625C',
  '6684-0000-033D-AB0F',
  'EDB2-0000-033E-52D2',
  '4272-0000-033E-668D',
  '6B53-0000-033F-0B33',
  '96DD-0000-0340-3722',
  'D6CE-0000-0340-3F5D',
  '59F9-0000-0341-CFC9'
]


PIDs = [
  "RZudomon",
  "lukengl",
  "WIIUREOLI79",
  "adsosabado",
  "Bibibombinha",
  "jogo_jogos",
  "brayer.souza",
  "Stopinski"
]

# "xTorviCx"

def csv2db(filename)
  row_no = 0
  CSV.foreach(filename, headers: true, header_converters: :symbol, encoding: 'utf-8') do |row|
    col_no = 2
    pid = PIDs[row_no]
    CIDs.each do |cid|
      new_rating(row[col_no].to_i, row[col_no + 1], pid, cid)
      col_no += 2
    end
    row_no += 1
  end
end

def import_challenge
  challenge_ID = new_challenge(THEME, nil, nil)
  CIDs.each do |cid|
    add_maker_n_course_to_db(cid, challenge_ID)
  end
  csv2db(RATINGS_CSV_FILE)
  challenge_ID
end