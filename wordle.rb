#!/usr/bin/env ruby

# Per the https://wordfinder.yourdictionary.com/wordle/answers/ archive:
#
#   ID  | DATE
#    0  | 2021-06-19
#  100  | 2021-09-27
#  200  | 2022-01-05
#  300  | 2022-04-15
#  400  | 2022-07-24
#  500  | 2022-11-01
#  600  | 2023-02-09

class Wordle
  @@epoch = Time.new(2021, 6, 19, 12)
  @@today = Time.now
  @@day_sec = 86400

  def initialize()
    @table = {}
  end

  def range(initial, terminal)
    (initial..terminal).map { |id| get(id) }
  end

  def get(id_or_date)
    if id_or_date.is_a?(Numeric)
      get_id(id_or_date.to_i)
    elsif id_or_date.is_a?(String)
      get_date(id_or_date)
    else
      raise
    end
  end

  def get_id(id)
    unless @table.key?(id)
      @table[id] = Time.at(@@epoch + id * @@day_sec)
    end
    @table.assoc(id)
  end

  def get_date(date)
    unless @table.has_value?(date)
      parts = date.split('-').map {|part| part.to_i}
      that_date = Time.new(parts[0], parts[1], parts[2], 12)
      id = ((that_date - @@epoch)/@@day_sec).to_i
      @table[id] = date
    end
    @table.rassoc(date)
  end

  def parse(raw_text)
  end

  def prompt
    write('ID: ')
    @id = readline.chomp.to_i
    @date = Time.at(@@epoch + @id * 86400)
  end
end
