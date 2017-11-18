require 'csv'
require_relative 'registration'
require_relative 'new_challenge'

# THEME = "Super Heroes"

# RATINGS_CSV_FILE = "super_heroi.csv"

# CIDs = [
#   'A808-0000-033C-C953',
#   'EA2F-0000-033D-625C',
#   '6684-0000-033D-AB0F',
#   'EDB2-0000-033E-52D2',
#   '4272-0000-033E-668D',
#   '6B53-0000-033F-0B33',
#   '96DD-0000-0340-3722',
#   'D6CE-0000-0340-3F5D',
#   '59F9-0000-0341-CFC9'
# ]


# PIDs = [
#   "RZudomon",
#   "lukengl",
#   "WIIUREOLI79",
#   "adsosabado",
#   "Bibibombinha",
#   "jogo_jogos",
#   "brayer.souza",
#   "Stopinski",
#   "xTorviCx"
# ]

# THEME = "Adaptation"

# RATINGS_CSV_FILE = "adaptacao.csv"

# CIDs = [
#   'C6B5-0000-0344-5C27',
#   '370A-0000-0345-106A',
#   '274E-0000-0345-D924',
#   '5F8F-0000-0346-DDB8',
#   'EE5C-0000-0347-6885',
#   'A61E-0000-0349-114E',
#   'E376-0000-0349-8457'
# ]


# PIDs = [
#   "lukengl",
#   "Marcyiello",
#   "jogo_jogos",
#   "Zudomon2",
#   "Bearpamela",
#   "xTorviCx",
#   "adsosabado"
# ]

# THEME = 'Music'

# RATINGS_CSV_FILE = 'music.csv'

# CIDs = [
#   'F7CE-0000-034D-EBCF',
#   '68D8-0000-034E-6D04',
#   'A2F8-0000-034F-3B4F',
#   'A145-0000-0351-8282',
#   'E4A0-0000-0353-0244',
#   '736B-0000-0353-73E2',
#   '6D80-0000-0353-D816'
# ]

# # In oder of response submission!
# PIDs = [
#   'WIIUREOLI79',
#   'Bibibombinha',
#   'gus.azv',
#   'Marcyiello',
#   'brayer.souza',
#   'Zudomon2',
#   'adsosabado'
# ]

# THEME = 'Careers'

# RATINGS_CSV_FILE = 'careers.csv'

# CIDs = [
#   '44E2-0000-0358-BB1F',
#   '8DE0-0000-0357-DF94',
#   '3818-0000-0357-FE59',
#   'C676-0000-035A-7659',
#   '1B3A-0000-035B-044A',
#   '9B8D-0000-035B-B62C',
#   '244C-0000-035D-0F1E'
# ]

# # In oder of response submission!
# PIDs = [
#   'Ghost_TF141_MW2',
#   'Zudomon2',
#   'Gessualdo',
#   'Stopinski',
#   'Marcyiello',
#   'adsosabado',
#   'xTorviCx'
# ]

# THEME = 'Ghost House'
#
# RATINGS_CSV_FILE = 'ghosthouse.csv'
#
# CIDs = [
#   '2F41-0000-0361-6D32',
#   '4862-0000-0361-8C64',
#   '8A87-0000-0361-CAA9',
#   '2D7C-0000-0362-2D8A',
#   'D927-0000-0362-39CE',
#   '1C00-0000-0362-499C',
#   '80F1-0000-0362-B02A',
#   '9E8D-0000-0363-6594',
#   'BFFC-0000-0363-D14C',
#   '91CF-0000-0364-52C6',
#   '5A26-0000-0365-367E'
# ]
#
# # In oder of response submission!
# PIDs = [
# 'Bibibombinha',
# 'WIIUREOLI79',
# 'Stopinski',
# 'Marcyiello',
# 'adsosabado',
# 'xTorviCx',
# 'rage_jcs',
# 'suller.souza',
# 'ricozzy',
# 'brayer.souza',
# 'gus.azv'
# ]

THEME = 'Remix SMB3'

RATINGS_CSV_FILE = 'smb3.csv'

CIDs = [
  '4E0E-0000-0367-F936',
  'DC4E-0000-0368-6C7F',
  '37B3-0000-0368-D5A8',
  'C807-0000-0369-5174',
  '8965-0000-0369-6135',
  '39C2-0000-0369-ABCE',
  'A945-0000-036A-24E8',
  '38AE-0000-036A-295D',
  '5E64-0000-036B-5A73',
  '28C5-0000-036B-B87C',
  '3D06-0000-036B-E2CE'
]

# In oder of response submission!
PIDs = [
'Ghost_TF141_MW2',
'Bearpamela',
'Stopinski',
'EmmanoelXD',
'Marcyiello',
'ricozzy',
'JuniorGolden',
'rage_jcs',
'adsosabado',
'xTorviCx',
'brayer.souza'
]

def csv2db(filename)
  row_no = 0
  CSV.foreach(filename, headers: true, header_converters: :symbol, encoding: 'utf-8') do |row|
    col_no = 2
    pid = PIDs[row_no]
    p pid, row[1]
    CIDs.each do |cid|
      p row[col_no + 1]
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
