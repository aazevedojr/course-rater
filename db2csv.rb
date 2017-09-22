@results_table = <<-SQL
SELECT c.title, SUM(CAST(r.rating -1 AS float) / total_per_rater.total_rating) AS final_rating
FROM reviews AS r
LEFT JOIN courses AS c ON r.course_id = c.id
LEFT JOIN makers AS m ON r.maker_id = m.id
LEFT JOIN (
  SELECT r.maker_id AS maker_id, SUM(r.rating - 1) AS total_rating
  FROM reviews AS r
  LEFT JOIN courses AS c ON r.course_id = c.id
  WHERE r.maker_id != c.maker_id AND c.challenge_id = ?
  GROUP BY r.maker_id
) AS total_per_rater ON r.maker_id = total_per_rater.maker_id
WHERE m.id != c.maker_id AND c.challenge_id = ?
GROUP BY c.id
ORDER BY final_rating DESC
SQL

def save_results(challenge_id, output_file)
  results = @db.execute(@results_table, [challenge_id, challenge_id])
  CSV.open(output_file, 'w') do |csv|
    results.each do |result|
      csv << result
    end
  end
end