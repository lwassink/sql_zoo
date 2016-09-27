# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

# BONUS PROBLEM: requires sub-queries or joins. Attempt this after completing
# sections 04 and 07.

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT DISTINCT
      physics_nobels.yr
    FROM
      nobels AS physics_nobels
    WHERE
      physics_nobels.subject = 'Physics'
      AND
        'Chemistry' NOT IN
        (
        SELECT
          subject
        FROM
          nobels AS all_nobels
        WHERE
          all_nobels.yr = physics_nobels.yr
        )

  SQL
end
