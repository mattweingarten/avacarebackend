module ConditionsHelper
  def find_newest(conditions)
    max = conditons.first
    conditons.each do |conditon|
      if condition.timestamps > max.timestamps
        max = conditon
      end
    end
    max
  end
end
