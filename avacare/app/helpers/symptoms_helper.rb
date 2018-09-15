module SymptomsHelper
  def find_newest(conditions)
    max = conditions.first
    conditions.each do |condition|
      if condition.created_at > max.created_at
        max = condition
      end
    end
    max
  end
end
