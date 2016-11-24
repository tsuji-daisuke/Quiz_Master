# respect! :http://d.hatena.ne.jp/myokoym/20100919/1284887970
class Numeric
  def to_en
    return self.to_s unless self.is_a?(Integer)
    case self
      when 1
        'one'
      when 2
        'two'
      when 3
        'three'
      when 4
        'four'
      when 5
        'five'
      when 6
        'six'
      when 7
        'seven'
      when 8
        'eight'
      when 9
        'nine'
      when 10
        'ten'
      when 11
        'eleven'
      when 12
        'twelve'
      when 13
        'thirteen'
      when 14
        'fourteen'
      when 15
        'fifteen'
      when 16
        'sixteen'
      when 17
        'seventeen'
      when 18
        'eighteen'
      when 19
        'nineteen'
      when 20
        'twenty'
      when 30
        'thirty'
      when 40
        'forty'
      when 50
        'fifty'
      when 60
        'sixty'
      when 70
        'seventy'
      when 80
        'eighty'
      when 90
        'ninety'
      when 21 .. 99
        x_one = self % 10
        x_ten = self - x_one
        x_ten.to_en + '-' + x_one.to_en
      when 100 .. 999
        front_num = self / 100
        rear_num = self % 100
        if rear_num == 0
          front_num.to_en + ' hundred'
        else
          front_num.to_en + ' hundred and ' + rear_num.to_en
        end
      when 1e3 .. 999999
        front_num = self / 1000
        rear_num = self % 1000
        if rear_num == 0
          front_num.to_en + ' thousand'
        else
          front_num.to_en + ' thousand and ' + rear_num.to_en
        end
      when 1e6 .. 999999999
        front_num = self / 1000000
        rear_num = self % 1000000
        if rear_num == 0
          front_num.to_en + ' million'
        else
          front_num.to_en + ' million and ' + rear_num.to_en
        end
      when 1e9 .. 999999999999
        front_num = self / 1000000000
        rear_num = self % 1000000000
        if rear_num == 0
          front_num.to_en + ' billion'
        else
          front_num.to_en + ' billion and ' + rear_num.to_en
        end
      when 1e12 .. 999999999999999
        front_num = self / 1000000000000
        rear_num = self % 1000000000000
        if rear_num == 0
          front_num.to_en + ' trillion'
        else
          front_num.to_en + ' trillion and ' + rear_num.to_en
        end
      else
        self.to_s
    end
  end
end